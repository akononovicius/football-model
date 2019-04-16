% out = applyDataMask( dataStruct, mask )
%
% Apply logical or ordering mask on the all fields within data structure.
%
% In:
%   dataStruct - data structure to apply the mask on
%   mask - mask we want to apply on all fields within data structure
%          (note that mask can be both logical vector, if you intend to
%          filter values, and integer vector, if you want to rearange
%          values)
%
% Out:
%   out - data structure on whose fields the mask was already applied
%
function out = applyDataMask(dataStruct, mask)
    fields = fieldnames(dataStruct);
    out = struct();
    for i = 1:length(fields)
        values = getfield(dataStruct, fields{i});
        out = setfield(out, fields{i}, values(mask));
    end
end
