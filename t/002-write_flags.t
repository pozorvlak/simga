#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags 'ecc_args';
use Test::More tests => 20;

is(ecc_args(0.01, 66, 26, 21, 70, 84, 36, 30, 68, 74, 77, 13, 12, 30),
'-bt 0.66 -bw_noreturn 0.26 -bw_non_equal 0.21 -bw_pointer 0.7 -bw_positive 0.84 -bw_float 0.36 -bw_call 0.3 -bw_neg_return 0.68 -bw_null_return 0.74 -bw_const_return 0.77 -bw_loop_header 0.13 -bw_loop_branch 0.12 -bw_loop_exit 0.3');
is(ecc_args(0.01, 2, 86, 79, 50, 42, 77, 50, 43, 38, 60, 3, 2, 15),
'-bt 0.02 -bw_noreturn 0.86 -bw_non_equal 0.79 -bw_pointer 0.5 -bw_positive 0.42 -bw_float 0.77 -bw_call 0.5 -bw_neg_return 0.43 -bw_null_return 0.38 -bw_const_return 0.6 -bw_loop_header 0.03 -bw_loop_branch 0.02 -bw_loop_exit 0.15');
is(ecc_args(0.01, 81, 95, 30, 61, 41, 87, 37, 14, 14, 88, 41, 23, 42),
'-bt 0.81 -bw_noreturn 0.95 -bw_non_equal 0.3 -bw_pointer 0.61 -bw_positive 0.41 -bw_float 0.87 -bw_call 0.37 -bw_neg_return 0.14 -bw_null_return 0.14 -bw_const_return 0.88 -bw_loop_header 0.41 -bw_loop_branch 0.23 -bw_loop_exit 0.42');
is(ecc_args(0.01, 76, 97, 57, 45, 48, 64, 81, 27, 20, 72, 91, 9, 84),
'-bt 0.76 -bw_noreturn 0.97 -bw_non_equal 0.57 -bw_pointer 0.45 -bw_positive 0.48 -bw_float 0.64 -bw_call 0.81 -bw_neg_return 0.27 -bw_null_return 0.2 -bw_const_return 0.72 -bw_loop_header 0.91 -bw_loop_branch 0.09 -bw_loop_exit 0.84');
is(ecc_args(0.01, 80, 94, 89, 21, 72, 86, 84, 65, 8, 28, 35, 94, 81),
'-bt 0.8 -bw_noreturn 0.94 -bw_non_equal 0.89 -bw_pointer 0.21 -bw_positive 0.72 -bw_float 0.86 -bw_call 0.84 -bw_neg_return 0.65 -bw_null_return 0.08 -bw_const_return 0.28 -bw_loop_header 0.35 -bw_loop_branch 0.94 -bw_loop_exit 0.81');
is(ecc_args(0.01, 57, 15, 23, 77, 57, 25, 51, 43, 77, 56, 65, 44, 71),
'-bt 0.57 -bw_noreturn 0.15 -bw_non_equal 0.23 -bw_pointer 0.77 -bw_positive 0.57 -bw_float 0.25 -bw_call 0.51 -bw_neg_return 0.43 -bw_null_return 0.77 -bw_const_return 0.56 -bw_loop_header 0.65 -bw_loop_branch 0.44 -bw_loop_exit 0.71');
is(ecc_args(0.01, 61, 86, 17, 98, 98, 78, 6, 71, 18, 15, 69, 33, 13),
'-bt 0.61 -bw_noreturn 0.86 -bw_non_equal 0.17 -bw_pointer 0.98 -bw_positive 0.98 -bw_float 0.78 -bw_call 0.06 -bw_neg_return 0.71 -bw_null_return 0.18 -bw_const_return 0.15 -bw_loop_header 0.69 -bw_loop_branch 0.33 -bw_loop_exit 0.13');
is(ecc_args(0.01, 7, 87, 86, 71, 54, 3, 40, 83, 6, 1, 14, 54, 90),
'-bt 0.07 -bw_noreturn 0.87 -bw_non_equal 0.86 -bw_pointer 0.71 -bw_positive 0.54 -bw_float 0.03 -bw_call 0.4 -bw_neg_return 0.83 -bw_null_return 0.06 -bw_const_return 0.01 -bw_loop_header 0.14 -bw_loop_branch 0.54 -bw_loop_exit 0.9');
is(ecc_args(0.01, 96, 75, 69, 62, 18, 53, 61, 1, 82, 12, 15, 16, 29),
'-bt 0.96 -bw_noreturn 0.75 -bw_non_equal 0.69 -bw_pointer 0.62 -bw_positive 0.18 -bw_float 0.53 -bw_call 0.61 -bw_neg_return 0.01 -bw_null_return 0.82 -bw_const_return 0.12 -bw_loop_header 0.15 -bw_loop_branch 0.16 -bw_loop_exit 0.29');
is(ecc_args(0.01, 38, 36, 7, 62, 0, 59, 23, 69, 36, 46, 6, 31, 39),
'-bt 0.38 -bw_noreturn 0.36 -bw_non_equal 0.07 -bw_pointer 0.62 -bw_positive 0.0001 -bw_float 0.59 -bw_call 0.23 -bw_neg_return 0.69 -bw_null_return 0.36 -bw_const_return 0.46 -bw_loop_header 0.06 -bw_loop_branch 0.31 -bw_loop_exit 0.39');
is(ecc_args(0.01, 39, 3, 38, 4, 4, 5, 73, 60, 11, 81, 56, 64, 44),
'-bt 0.39 -bw_noreturn 0.03 -bw_non_equal 0.38 -bw_pointer 0.04 -bw_positive 0.04 -bw_float 0.05 -bw_call 0.73 -bw_neg_return 0.6 -bw_null_return 0.11 -bw_const_return 0.81 -bw_loop_header 0.56 -bw_loop_branch 0.64 -bw_loop_exit 0.44');
is(ecc_args(0.01, 19, 91, 61, 73, 4, 44, 32, 10, 70, 90, 54, 81, 15),
'-bt 0.19 -bw_noreturn 0.91 -bw_non_equal 0.61 -bw_pointer 0.73 -bw_positive 0.04 -bw_float 0.44 -bw_call 0.32 -bw_neg_return 0.1 -bw_null_return 0.7 -bw_const_return 0.9 -bw_loop_header 0.54 -bw_loop_branch 0.81 -bw_loop_exit 0.15');
is(ecc_args(0.01, 64, 32, 50, 4, 13, 41, 14, 11, 33, 0, 96, 6, 68),
'-bt 0.64 -bw_noreturn 0.32 -bw_non_equal 0.5 -bw_pointer 0.04 -bw_positive 0.13 -bw_float 0.41 -bw_call 0.14 -bw_neg_return 0.11 -bw_null_return 0.33 -bw_const_return 0.0001 -bw_loop_header 0.96 -bw_loop_branch 0.06 -bw_loop_exit 0.68');
is(ecc_args(0.01, 26, 49, 53, 29, 93, 10, 68, 45, 7, 95, 29, 60, 76),
'-bt 0.26 -bw_noreturn 0.49 -bw_non_equal 0.53 -bw_pointer 0.29 -bw_positive 0.93 -bw_float 0.1 -bw_call 0.68 -bw_neg_return 0.45 -bw_null_return 0.07 -bw_const_return 0.95 -bw_loop_header 0.29 -bw_loop_branch 0.6 -bw_loop_exit 0.76');
is(ecc_args(0.01, 45, 42, 44, 95, 77, 8, 69, 23, 35, 10, 84, 42, 97),
'-bt 0.45 -bw_noreturn 0.42 -bw_non_equal 0.44 -bw_pointer 0.95 -bw_positive 0.77 -bw_float 0.08 -bw_call 0.69 -bw_neg_return 0.23 -bw_null_return 0.35 -bw_const_return 0.1 -bw_loop_header 0.84 -bw_loop_branch 0.42 -bw_loop_exit 0.97');
is(ecc_args(0.01, 94, 80, 67, 22, 65, 51, 81, 56, 2, 57, 69, 17, 92),
'-bt 0.94 -bw_noreturn 0.8 -bw_non_equal 0.67 -bw_pointer 0.22 -bw_positive 0.65 -bw_float 0.51 -bw_call 0.81 -bw_neg_return 0.56 -bw_null_return 0.02 -bw_const_return 0.57 -bw_loop_header 0.69 -bw_loop_branch 0.17 -bw_loop_exit 0.92');
is(ecc_args(0.01, 78, 8, 84, 69, 71, 24, 19, 48, 27, 95, 20, 30, 44),
'-bt 0.78 -bw_noreturn 0.08 -bw_non_equal 0.84 -bw_pointer 0.69 -bw_positive 0.71 -bw_float 0.24 -bw_call 0.19 -bw_neg_return 0.48 -bw_null_return 0.27 -bw_const_return 0.95 -bw_loop_header 0.2 -bw_loop_branch 0.3 -bw_loop_exit 0.44');
is(ecc_args(0.01, 15, 44, 98, 63, 88, 97, 87, 92, 32, 64, 5, 41, 9),
'-bt 0.15 -bw_noreturn 0.44 -bw_non_equal 0.98 -bw_pointer 0.63 -bw_positive 0.88 -bw_float 0.97 -bw_call 0.87 -bw_neg_return 0.92 -bw_null_return 0.32 -bw_const_return 0.64 -bw_loop_header 0.05 -bw_loop_branch 0.41 -bw_loop_exit 0.09');
is(ecc_args(0.01, 79, 23, 74, 19, 20, 40, 56, 52, 51, 13, 9, 72, 62),
'-bt 0.79 -bw_noreturn 0.23 -bw_non_equal 0.74 -bw_pointer 0.19 -bw_positive 0.2 -bw_float 0.4 -bw_call 0.56 -bw_neg_return 0.52 -bw_null_return 0.51 -bw_const_return 0.13 -bw_loop_header 0.09 -bw_loop_branch 0.72 -bw_loop_exit 0.62');
is(ecc_args(0.01, 84, 24, 14, 15, 14, 39, 23, 35, 35, 32, 9, 94, 37),
'-bt 0.84 -bw_noreturn 0.24 -bw_non_equal 0.14 -bw_pointer 0.15 -bw_positive 0.14 -bw_float 0.39 -bw_call 0.23 -bw_neg_return 0.35 -bw_null_return 0.35 -bw_const_return 0.32 -bw_loop_header 0.09 -bw_loop_branch 0.94 -bw_loop_exit 0.37');
