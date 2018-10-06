%
%
% This function will retrieve the geoseries file from the downloads folder,
% 

function [gse123] = getGSE(gseid,gplid)


if exist(gseid,'var');

gse123 = geoseriesread('/Users/dawnstear/Desktop/QSB/FINALPROJECT/GSE15852_series_matrix.txt');
get(gse123.Data);
d = gse123.Data;



end