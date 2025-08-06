;***************************************
;* Code to draw the precipitation & circulation
;* over the Amazon & Sahel regions
;* by Yue Li 2019.10.10
;***************************************
;---Load the NCL file that contains the gsn_* functions used below.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

;------ 1st functionto calculate the sum of water variable
undef("water_sum")
function water_sum (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric,area:numeric, filename1:string, scaleFactor:numeric)
begin
  
  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  dimz = dimsizes(area)
  var_mth = new((/30,dimz(0),dimz(1)/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = var&lat
    tmp&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------

;------ 1st functionto calculate the sum of water variable
undef("water_sum_cru")
function water_sum_cru (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,360,720/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------
;------ 1st functionto calculate the sum of water variable
undef("water_sum_cnfoc")
function water_sum_cnfoc (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var!0 = "time"
  var&time = ttt&time
  var!1 = "lat"
  var&lat = ttt&lat
  var!2 = "lon"
  var&lon = ttt&lon
  yr = 1982
  var_mth = new((/30,400,700/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era")
function water_sum_era (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  var@_FillValue = 1e+20
  yr = 1982
  var_mth = new((/30,91,180/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = var&lat
    tmp&lon = var&lon
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------
undef("water_sum_era2")
function water_sum_era2 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var@_FillValue = 1e+20
  kt = -32767*ttt@scale_factor+ttt@add_offset
  var = where(var .le. kt, var@_FillValue, var)
  yr = 1982
  var_mth = new((/30,241,480/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp1 = dim_sum_n_Wrap(var((yr-yearref)*12*4+(beginmth-1)*4+1-1:(yr-yearref)*12*4+endmth*4-1,:,:),0)

    tmp = tmp1/(endmth-beginmth+1)
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = ttt&latitude
    tmp&lon = ttt&longitude
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era5_avg")
function water_sum_era5_avg (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  ;var@_FillValue = 1e+20
  if(beginmth .eq. 12)
    var(2,:,:) = var(11,:,:)
    tmp = dim_avg_n_Wrap(var(0:2,:,:),0)
  else
    tmp = dim_avg_n_Wrap(var(beginmth-1:endmth-1,:,:),0)
  end if

  tmp = tmp*scaleFactor
  return ([/tmp/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era5_vert_avg")
function water_sum_era5_vert_avg (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  ;var@_FillValue = 1e+20
  if(beginmth .eq. 12)
    var(2,:,:,:) = var(11,:,:,:)
    tmp = dim_avg_n_Wrap(var(0:2,7,:,:),0) ; set pres level to 7 as '850hPa'
  else
    tmp = dim_avg_n_Wrap(var(beginmth-1:endmth-1,7,:,:),0)
  end if

  tmp = tmp*scaleFactor
  return ([/tmp/])
end


undef("water_sum_era_uv10")
function water_sum_era_uv10 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var@_FillValue = 1e+20
  kt = -32767*ttt@scale_factor+ttt@add_offset
  var = where(var .le. kt, var@_FillValue, var)
  yr = 1982
  var_mth = new((/30,241,480/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_sum_n_Wrap(var((yr-yearref)*12+(beginmth-1):(yr-yearref)*12+endmth-1,:,:),0)
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = ttt&latitude
    tmp&lon = ttt&longitude
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    delete(tmp)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_merra")
function water_sum_merra (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,361,540/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp2 = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp2 = tmp2*scaleFactor
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&YDim
    tmp2&lon = var&XDim
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_ncep")
function water_sum_ncep (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,94,192/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp2 = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    tmp2 = tmp2*scaleFactor
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&lat
    tmp2&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_ncep2")
function water_sum_ncep2 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,73,144/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:,:),0)
    tmp = tmp*scaleFactor
    tmp2 = rm_single_dims(tmp)
    ;print(tmp2)
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&lat
    tmp2&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end


undef("vector_plot")
function vector_plot(nb:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res_vc                            = res
  res_vc@vcGlyphStyle               = "LineArrow"
  res_vc@vcLineArrowThicknessF      = 0.8
  res_vc@vcMinDistanceF             = 0.04
  res_vc@vcRefLengthF               = 0.05

;;wind barb resources don't apply
;;      res_vc@vcGlyphStyle               = "WindBarb"
;;      res_vc@vcWindBarbLineThicknessF   = 5
;;      res_vc@vcWindBarbColor            = "Gray40"

  res_vc@vcRefAnnoOn               = True
  res_vc@vcRefMagnitudeF           = 1.5
  res_vc@vcRefAnnoString1          = "1.5m/s"
  res_vc@vcRefAnnoSide             = "Top"
  res_vc@vcRefAnnoString2On        = False
  res_vc@vcRefAnnoPerimOn          = False
  res_vc@vcRefAnnoOrthogonalPosF   = -0.05
  res_vc@vcRefAnnoParallelPosF     = 1
  res_vc@vcRefAnnoBackgroundColor  = "White"
  res_vc@vcVectorDrawOrder         = "PostDraw"
  res_vc@gsnRightString            = ""
  res_vc@vcLineArrowColor          = "Red"
  res_vc@vcGlyphStyle              = "CurlyVector"
  return(res_vc)
end

;-------2 nd function to create original plot
undef("pattern_plot")
function pattern_plot (nb:string, varunit:string, PaletteColor:string, levelmode:string,levels:numeric, varname:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@gsnCenterString = "";Timescale_name
  ;res@gsnRightString = varunit
  res@gsnLeftString = varname
  ;res@gsnLeftStringFontHeightF = 0.01
  ;res@gsnRightStringFontHeightF = 0.01
  res@gsnLeftStringFontColor = "black"
  res@gsnPaperOrientation = "portrait"

  ;res@gsnRightString = "Jan_1982_Veg3"
  res@cnFillPalette = PaletteColor
  res@cnFillOn = True
  res@tiMainString = "";Mainstring_name
  res@cnLevelSelectionMode = levelmode
  res@cnLevels = levels
  res@cnLinesOn = False

  res@vpWidthF = 0.6
  res@vpHeightF = 0.3

  res@mpFillOn = True
  res@mpOutlineOn = True
  res@mpGeophysicalLineColor = "Gray21"
  res@mpMaxLatF = 90
  res@mpMinLatF = -60
  res@mpMaxLonF = 180
  res@mpMinLonF = -180
  ;res@tmXBValues = (/-90,-60,-30,0,30,60,90,120,150/)
  ;res@tmXBLabels = (/"90~S~o~N~W","60~S~o~N~W","30~S~o~N~W","0~S~o~N~","30~S~o~N~E","60~S~o~N~E","90~S~o~N~E","120~S~o~N~E","150~S~o~N~E"/)
  ;res@tmYLValues = (/-30,0,30/)
  ;res@tmYLLabels = (/"30~S~o~N~S","0~S~o~N~","30~S~o~N~N"/)

  res@mpDataBaseVersion = "Ncarg4_1"
  res@mpDataSetName = "Earth..4"
  ;res@mpOutlineSpecifiers = (/"China","Taiwan"/)
  res@mpGeophysicalLineThicknessF = 1
  res@mpNationalLineThicknessF    = 1

  res@pmLabelBarWidthF = 0.6
  res@pmLabelBarHeightF = 0.03
  res@pmLabelBarOrthogonalPosF = 0.25
  res@lbTitleString    = ""
  res@lbTitleFontHeightF = 0.01
  res@lbTitlePosition = "Bottom"
  ;res@lbBoxEndCapStyle = "TriangleBothEnds"

  ;res@tiYAxisFontHeightF = 0.01
  ;res@tiXAxisFontHeightF = 0.01
  ;res@lbLabelFontHeightF = 0.01
  res@tmXBLabelFontHeightF = 0.01
  res@tmYLLabelFontHeightF = 0.01
  res@tmXBOn            = False
  res@tmYLOn            = False
  res@tmXTOn            = False
  res@tmYROn            = False
  res@cnRasterModeOn = True

  res@lbTitleFontHeightF = 0.01
  res@lbLabelFontHeightF = 0.01 
  return(res)
end

undef("pattern_plot2")
function pattern_plot2 (nb:string, varunit:string, PaletteColor:string, levelmode:string,levels:numeric, varname:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@gsnPaperOrientation = "portrait"

  res@cnFillPalette = PaletteColor
  res@cnFillOn = False
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnLevels = levels
  res@cnLinesOn = True
  res@cnLineColor = "green"
  res@cnLineLabelDensityF = 3.0

  res@vpWidthF = 0.6
  res@vpHeightF = 0.3

  res@mpFillOn = False

  if(nb .eq. "e") then
    res@gsnAddCyclic = False
  end if
  return (res)
;draw(mmap)
;frame(wks)
end

undef("get_color")
function get_color (value:numeric)
begin
  if(value .le. -1) then
    color=(/165., 0., 33./)
  else if(value .ge. -1 .and. value .lt. -0.8) then
    color=(/246., 38., 52./)
  else if(value .ge. -0.8 .and. value .lt. -0.6) then
    color=(/255., 61., 61./)
  else if(value .ge. -0.6 .and. value .lt. -0.4) then
    color=(/255., 172., 117./)
  else if(value .ge. -0.4 .and. value .lt. -0.2) then
    color=(/255., 214., 153./)
  else if(value .ge. -0.2 .and. value .lt. 0) then
    color=(/255., 255., 233./)
  else if(value .ge. 0 .and. value .lt. 0.2) then
    color=(/233., 255., 255./)
  else if(value .ge. 0.2 .and. value .lt. 0.4) then
    color=(/153., 233., 255./)
  else if(value .ge. 0.4 .and. value .lt. 0.6) then
    color=(/117., 211., 255./)
  else if(value .ge. 0.6 .and. value .lt. 0.8) then
    color=(/61., 135., 255./)
  else if(value .ge. 0.8 .and. value .lt. 1) then
    color=(/40., 86., 255./)
  else
    color=(/35., 0., 216./)
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  color = color/255
  return(color)
end

;------------------------ function labelbar
undef("attach_labelbar")
function attach_labelbar(wks,plot,labels,colors)
local lbres, vph, vpw, nboxes
begin
  nboxes = dimsizes(labels)
  getvalues plot                      ; Get plot size for use in
    "vpHeightF" : vph                 ; creating labelbar.
    "vpWidthF"  : vpw
  end getvalues

  lbres                    = True          ; labelbar only resources
  lbres@lbAutoManage       = False          ; Necessary to control sizes
  lbres@lbPerimOn          = False
  ;lbres@cnLabelBarEndStyle = "IncludeOuterBoxes"
  lbres@lbLabelPosition    = "Right"
  lbres@lbLabelAlignment   = "InteriorEdges"
  lbres@lbOrientation 	   = "Horizontal"
  lbres@vpWidthF           = 0.95 *  vpw     ; labelbar width
  lbres@vpHeightF          = 0.16 * vph           ; labelbar height
  lbres@lbLabelOffset      = 0.03
  lbres@lbFillColors       = colors
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.01          ; font height. default is small
  lbres@lbBoxLinesOn       = True

  lbid = gsn_create_labelbar(wks,nboxes,labels,lbres)
;
; Now, create some annotation resources indicating how we want to
; attach the labelbar to the plot.
;                                                                 
  amres                = True
  amres@amParallelPosF = 0     ; Move away from plot
  amres@amOrthogonalPosF = 0.68
  annoid = gsn_add_annotation(plot,lbid,amres)

  return(annoid)
end
;--------------------------------




;=================================================    main function    =============================================
begin
;***************************** user define ******************************
var_name2 = "precip"

scaleFactor2 = 86400; for LE

units2 = "";for LE
units2_0 = "trend, mm/d/30yrs"
units1 = "m/s"; for PRE
units1_0 = "m/s/30yrs"
units3 = ""
units3_0 = "m/s/30yrs"

cmap2_0 = read_colormap_file("MPL_YlOrBr")
;print(cmap2_0)
colortable1 = cmap2_0
cmap2 = read_colormap_file("ncl_default")
colortable2 = cmap2
colortable3 = cmap2_0
levelmode = "ExplicitLevels"
;levelmode = "AutomaticLevels"

levels1 = fspan(5, 70, 14) 
levels2 = fspan(-7,7,15)
levels2_0 = (/-2, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 2/)
levels3 = fspan(-3.,3.,21) 
levels3_0 = (/-1, -0.6, -0.3, 0, 0.3, 0.6, 1/)

;*******************************************************************************
area_name = "Areas"
;filename = "/home/liyue/th-1a/areas.nc"
;f = addfile(filename,"r")
;area = f->$area_name$
yearref = 1982
beginmth = 1 
endmth = 12
scenarios1="S1"
scenarios2="S2"
ens_name = "ens10"

; -------------------------------------------------------------------draw the plot
graphname = "map_fire_90pct_burn_newhtwvdef_onlyfire.new21"
wks_type          = "pdf"
wks_type@wkWidth  = 1450          ; Make X11 window larger. Default
wks_type@wkHeight = 900
wks = gsn_open_wks(wks_type,graphname);

mmap = new(3,graphic)

seasoname =(/"DJF","MAM","JJA","SON"/)
nbb = (/"a","b","c","d","e","f","g","h","i","j","k","l"/)

;-------------------------------------------------------------------------draw precipitation from a variety sources

filename1 = "fire_100pct_burnedarea_newhtwvdef.new21.nc"
f = addfile(filename1,"r")
fbaall = f->fbaalln
firefn2003 = fbaall
firefn2003 = where(firefn2003 .eq. 0, firefn2003@_FillValue, firefn2003)
firefn2003 = where(firefn2003 .gt. 0, 60, firefn2003@_FillValue)
nb = "a"
result1 = pattern_plot (nb, units1, colortable1, levelmode,levels1,"")
res = result1
res@cnFillOn = True
res@cnFillMode = "CellFill"
res@cnLinesOn = False
;res@cnRasterSmoothingOn = False
res@cnConstFEnableFill = True
map = gsn_csm_contour_map(wks,firefn2003,res)
mmap(1) = map
delete(map)
delete(firefn2003)

filename1 = "fire_90pct_burnedarea_newhtwvdef.new21.nc"
f = addfile(filename1,"r")
fbaalln = f->fbaalln
firefn2003 = fbaalln 
firefn2003 = where(firefn2003 .eq. 0, firefn2003@_FillValue, firefn2003)
firefn2003 = where(firefn2003 .gt. 0, 60, firefn2003@_FillValue)
nb = "a"
result1 = pattern_plot (nb, units1, colortable1, levelmode,levels1,"")
res = result1
res@cnFillOn = True
res@cnFillMode = "CellFill"
res@cnLinesOn = False
;res@cnRasterSmoothingOn = False
res@cnConstFEnableFill = True
map = gsn_csm_contour_map(wks,firefn2003,res)
mmap(2) = map
delete(map)

gsn_panel(wks,mmap,(/3,1/),False)

end
