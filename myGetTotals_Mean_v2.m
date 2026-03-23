function [t, files] = myGetTotals_Mean_v2(files, msk)


% Script adapted from Ged Ridgway's MATLAB script: http://www0.cs.ucl.ac.uk/staff/g.ridgway/vbm/get_totals.m

% Returns the average voxel value within the binary mask "msk" for the images
% listed in "files".

% Example
%[t1, files1] = myGetTotals_Mean('GM_map01_mni.nii', 'mask01_mni.nii');
%[t2, files2] = myGetTotals_Mean('GM_map00_mni.nii', 'mask02_mni.nii');

% [Currently, masking assumes that msk matches the voxel dimensions of each
% image, and that therefore, all images have the same dimensions.]




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

t = zeros(N,1);
for n = 1:N
    img = spm_read_vols(vols(n));
    img = img .* msk;    
    t(n) = sum(img(img > 0))/size(find(img > 0),1);
end
