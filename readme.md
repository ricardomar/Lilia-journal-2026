# myGetTotals_Mean

This script is adapted from Ged Ridgway's MATLAB script: [get_totals.m](http://www0.cs.ucl.ac.uk/staff/g.ridgway/vbm/get_totals.m).

## Description
The script returns the average voxel value (`a`) within a binary mask (`msk`) for the image listed in `file`.

**Note on Dimensions:**
The masking process assumes that the `msk` matches the voxel dimensions of each image; therefore, the image and mask must share the same dimensions.

## Example Usage
```matlab
[a01, f01] = myGetTotals_Mean('GM_map01_mni.nii', 'mask01_mni.nii');
[a02, f02] = myGetTotals_Mean('GM_map02_mni.nii', 'mask02_mni.nii');
