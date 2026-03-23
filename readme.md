
Script adapted from Ged Ridgway's MATLAB script: http://www0.cs.ucl.ac.uk/staff/g.ridgway/vbm/get_totals.m

Returns the average voxel value within the binary mask "msk" for the images listed in "files".

Currently, masking assumes that msk matches the voxel dimensions of each image, and that therefore, all images have the same dimensions.

Example:

[t1, files1] = myGetTotals_Mean('GM_map01_mni.nii', 'mask01_mni.nii');.

[t2, files2] = myGetTotals_Mean('GM_map00_mni.nii', 'mask02_mni.nii');


