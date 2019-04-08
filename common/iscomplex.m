function output_args  = iscomplex( input_args )
%ISCOMPLEX if input_args is complex return 1; otherwise return 0
%   output_args  = iscomplex( input_args )
output_args = ~isreal(input_args);

end

