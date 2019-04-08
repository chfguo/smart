function data = gfgpu(dat)
%GFGPU copies the single version of numeric data to the GPU
%   dat_gpu = gfgpu(dat_cpu)

data=gpuArray(single(dat));
end

