;************************************************
;vegland_2.ncl
;************************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"    
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"    

begin
  f      = addfile ("climate_region5_fireseason.nc", "r")           ; read as he2

;  info = (/                             \ ;Majority_Land_Cover_Type_1
;        " 1 ALA"      ,\ ;_forest
;        " 2 CGI"       ,\ ;_forest     
;        " 3 WNA"      ,\ ;_forest
;        " 4 CNA"       ,\ ;_forest     
;        " 5 ENA"             ,\
;        " 6 CAM"          ,\
;        " 7 AMZ"           ,\
;        " 8 NEB"            ,\
;        " 9 WSA"                  ,\
;        " 10 SSA"               ,\
;        " 11 NEU"       ,\
;        " 12 CEU"                ,\
;        " 13 MED"       ,\
;        " 14 SAH"      ,\ ; cropland_natural_vegetation_mosaic
;        " 15 NAF"             ,\
;        " 16 SAF"         ,\ ; barren_or_sparsely_vegetated       
;        " 17 NAS"         ,\ ; barren_or_sparsely_vegetated       
;        " 18 WAS"         ,\ ; barren_or_sparsely_vegetated       
;        " 19 CAS"         ,\ ; barren_or_sparsely_vegetated       
;        " 20 TIB"         ,\ ; barren_or_sparsely_vegetated       
;        " 21 EAS"         ,\ ; barren_or_sparsely_vegetated       
;        " 22 SAS"         ,\ ; barren_or_sparsely_vegetated       
;        " 23 SEA"         ,\ ; barren_or_sparsely_vegetated       
;        " 24 NAU"         ,\ ; barren_or_sparsely_vegetated       
;        " 25 SAU"             /)

info = (/	\
	" 1 Jan"	,\
	" 2 Feb"	,\
	" 3 Mar"	,\
	" 4 Apr" 	,\
	" 5 May"	,\
	" 6 Jun"	,\
	" 7 Jul"	,\
	" 8 Aug"	,\
	" 9 Sep"	,\
	" 10 Oct"	,\
	" 11 Nov"	,\
	" 12 Dec"	/)

  ninfo = dimsizes(info)        ; # of classifications
  print(ninfo)
  xhe   = f->exregion2
  printVarSummary(xhe)

;************************************************
; create plot
;************************************************
  pltType = "pdf"               ; ps, pdf, png, x11, eps
  ;sfx     = get_file_suffix(fili,0)

  pltDir  = "./"
 ;pltName = sfx@fBase+"."+region+"_majority"
  pltName = "figure_fireseason_newmap2"
  pltPath = pltDir + pltName

;  colorscheme = (/"antiquewhite", "beige", "cornsilk", "darkseagreen1","honeydew",\
;		"ivory","lemonchiffon","lightblue1","lightcyan","pink1",\
;		"lightskyblue1","lightsteelblue","mistyrose","moccasin","palegoldenrod","peachpuff",\
;		"lightgoldenrodyellow","slategray1","snow2","skyblue","wheat","thistle1","darkseagreen1","floralwhite","cornsilk2"/) 
;
;   colorscheme = (/"gray97", "gray95", "gray91", "gray87","gray83",\
;		"gray79","gray75","gray71","gray67","gray63",\
;		"gray97","gray95","gray91","gray87","gray83","gray79",\
;		"gray97","gray95","gray91","gray87","gray83","gray79","gray75","gray71","gray67"/) 

;colorscheme = (/"beige", "cornsilk", "darkseagreen1","honeydew",\
;               "ivory","lemonchiffon","lightblue1","lightcyan","pink1",\
;               "lightskyblue1","lightsteelblue","mistyrose"/)
; colorscheme = (/"cadetblue1", "darkgreen", "chartreuse", \
;		"mediumpurple1","mistyrose","burlywood3","gold",\
;		"tan1","royalblue","red","lightgoldenrod4",\
;		"lightsteelblue"/)
colorscheme = new((/12,3/),float)
colorscheme(0,:) = (/0, 170 ,225/)
colorscheme(1,:) =(/   0, 200, 200 /)     
colorscheme(2,:) =(/   0, 200, 125/)
colorscheme(3,:) =(/ 195, 255 ,  0/)
colorscheme(4,:) =(/ 255, 255 ,  0/)
colorscheme(5,:) =(/ 255, 100 ,  0/)
colorscheme(6,:) =(/ 255, 155 ,  0/)
colorscheme(7,:) =(/ 255  , 0  , 0/)
colorscheme(8,:) =(/ 100  , 0, 116/)
colorscheme(9,:) =(/ 120 ,  0, 136/)
colorscheme(10,:) =(/  90,   0, 184/)
colorscheme(11,:) =(/  70,   0, 245/)
colorscheme = colorscheme/255
 ; ncolors = dimsizes(colorscheme)
 ; if (ninfo.ne.ncolors) then            ; make sure # of colors match categories (classes)
 ;     print("size mismatch: ninfo="+ninfo+"   ncolors="+ncolors)
 ;     exit
 ; end if

  wks = gsn_open_wks(pltType,pltPath)  

  res                  = True                ; plot mods desired
  res@gsnDraw          = False
  res@gsnFrame         = False
  res@gsnMaximize      = True               ; ps, pdf 

  res@cnFillOn         = True               ; color Fill 
  res@cnFillMode       = "RasterFill" 
  res@cnLinesOn        =  False             ; Turn off contour lines
  res@cnLevelSelectionMode = "ExplicitLevels" ; set explict contour levels
  res@cnLevels         = tobyte( ispan(2,ninfo,1) )   ;one less than ninfo
  res@cnFillPalette    = colorscheme        ; distinct colors for categories
  res@gsnSpreadColors  = False              ; use each color sequentially

  res@lbLabelPosition  = "Center"           ; label position
  res@lbLabelAlignment = "BoxCenters"       ; label orientation
  res@lbLabelStrings   = ispan(1,ninfo,1)  
  res@lbLabelStride    = 1
  res@lbLabelAutoStride = False 	    ; in V6.1.0 and up, this is defaulted
					    ; to True, and overrides lbLabelStride
					    ; default. Set this to ensure that 
					    ; your label scheme is preserved.

  res@pmLabelBarHeightF        =  0.075
  res@pmLabelBarWidthF         =  0.60      ; default is 0.6
 ;res@pmLabelBarOrthogonalPosF = -0.0005    ; move up smidge

  res@mpFillOn         = False
  res@mpCenterLonF     = 0.0

;;res@mpGridAndLimbOn   = True
;;res@mpGridLatSpacingF = 5.0
;;res@mpGridLonSpacingF = 5.0
;;res@mpGridLineDashPattern = "2"

;;res@gsnAddCyclic  = False                  ; regional data   

  res@vpHeightF  = 0.5
  res@vpWidthF   = 0.5

  res@trGridType     = "TriangularMesh"

  ;res@tiMainString   = fili
  plot = gsn_csm_contour_map_ce(wks, xhe, res) ; create plot

  rtxt = True
  rtxt@txJust        = "TopLeft"
  rtxt@txFontHeightF = 0.010    ; 0.0075     ;  0125

; Add text: rows x columns of text (arbitrary)
; Usually must play with xx, yy and txFontHeightF

  ;nrow = 3       ; # rows
  ;ncol = 6       ; # columns

  ;n  = -1
  ;xx = 0.025                ; arbitrary
  ;do nc=0,ncol-1
  ;   yy = 0.22
  ;  do nr=0,nrow-1
  ;     n = n+1
  ;     if (n.le.(ninfo-1)) then
  ;         gsn_text_ndc (wks,info(n),xx,yy,rtxt)
  ;         yy = yy - 3*rtxt@txFontHeightF
  ;     end if
  ;  end do
  ;  xx = xx + 0.155
  ;end do

  draw(plot)
  frame(wks)

end
