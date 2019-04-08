function [ output_args ] = gfcellcat( input_args1,input_args2)
%GFCELLCAT Summary of this function goes here
%   Detailed explanation goes here
Num1=numel(input_args1);
Num2=numel(input_args2);
output_args=input_args1;
for in=Num1+1:Num1+Num2
    output_args{in}=input_args2{in-Num1};
end
end

