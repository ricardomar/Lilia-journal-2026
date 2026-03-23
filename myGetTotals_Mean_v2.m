function [a, f] = myGetTotals_Mean_v2(files, msk)


% Script adapted from Ged Ridgway's MATLAB script: http://www0.cs.ucl.ac.uk/staff/g.ridgway/vbm/get_totals.m

% The script returns the average voxel value (`a`) within a binary mask (`msk`) for the image listed in `file`.

% The masking process assumes that the `msk` matches the voxel dimensions of each image; therefore, the image and mask must share the same dimensions.


% Example usage
%[a01, f01] = myGetTotals_Mean('GM_map01_mni.nii', 'mask01_mni.nii');
%[a02, f02] = myGetTotals_Mean('GM_map02_mni.nii', 'mask02_mni.nii');


% check spm version:
if exist('spm_select','file') % should be true for spm5
    spm5 = 1;
    select = @(msg) spm_select(inf, 'image', msg);
elseif exist('spm_get','file') % should be true for spm2
    spm5 = 0;
    select = @(msg) spm_get(inf, 'img', msg);
else
    error('Failed to locate spm_get or spm_select; please add SPM to Matlab path')
end

if ( ~exist('files', 'var') || isempty(files) )
    files = select('choose images');
end

if ~exist('msk', 'var')
    msk = 1; % default to include everything
end
if isempty(msk)
    msk = select('Choose mask image');
end
if ischar(msk)
    msk = spm_vol(msk);
end
if isstruct(msk)
    msk = spm_read_vols(msk);
end
msk = msk ~= 0;

vols = spm_vol(files);
N = length(vols);

f=files;

a = zeros(N,1);
for n = 1:N
    img = spm_read_vols(vols(n));
    img = img .* msk;    
    a(n) = sum(img(img > 0))/size(find(img > 0),1);
end
