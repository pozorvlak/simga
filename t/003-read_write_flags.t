#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags qw/ecc_args parse_args/;
use Test::More tests => 40;

is(ecc_args(0.01, 31, 45, 86, 77, 86, 32, 78, 20, 57, 54, 85, 12, 90),
'-bt 0.31 -bw_noreturn 0.45 -bw_non_equal 0.86 -bw_pointer 0.77 -bw_positive 0.86 -bw_float 0.32 -bw_call 0.78 -bw_neg_return 0.2 -bw_null_return 0.57 -bw_const_return 0.54 -bw_loop_header 0.85 -bw_loop_branch 0.12 -bw_loop_exit 0.9');
is_deeply([parse_args(0.01, '-bt 0.31 -bw_noreturn 0.45 -bw_non_equal 0.86 -bw_pointer 0.77 -bw_positive 0.86 -bw_float 0.32 -bw_call 0.78 -bw_neg_return 0.2 -bw_null_return 0.57 -bw_const_return 0.54 -bw_loop_header 0.85 -bw_loop_branch 0.12 -bw_loop_exit 0.9')], [31, 45, 86, 77, 86, 32, 78, 20, 57, 54, 85, 12, 90]);
is(ecc_args(0.01, 44, 80, 27, 58, 6, 0, 10, 85, 17, 48, 10, 33, 42),
'-bt 0.44 -bw_noreturn 0.8 -bw_non_equal 0.27 -bw_pointer 0.58 -bw_positive 0.06 -bw_float 0 -bw_call 0.1 -bw_neg_return 0.85 -bw_null_return 0.17 -bw_const_return 0.48 -bw_loop_header 0.1 -bw_loop_branch 0.33 -bw_loop_exit 0.42');
is_deeply([parse_args(0.01, '-bt 0.44 -bw_noreturn 0.8 -bw_non_equal 0.27 -bw_pointer 0.58 -bw_positive 0.06 -bw_float 0 -bw_call 0.1 -bw_neg_return 0.85 -bw_null_return 0.17 -bw_const_return 0.48 -bw_loop_header 0.1 -bw_loop_branch 0.33 -bw_loop_exit 0.42')], [44, 80, 27, 58, 6, 0, 10, 85, 17, 48, 10, 33, 42]);
is(ecc_args(0.01, 22, 71, 73, 70, 53, 88, 56, 68, 39, 98, 23, 45, 40),
'-bt 0.22 -bw_noreturn 0.71 -bw_non_equal 0.73 -bw_pointer 0.7 -bw_positive 0.53 -bw_float 0.88 -bw_call 0.56 -bw_neg_return 0.68 -bw_null_return 0.39 -bw_const_return 0.98 -bw_loop_header 0.23 -bw_loop_branch 0.45 -bw_loop_exit 0.4');
is_deeply([parse_args(0.01, '-bt 0.22 -bw_noreturn 0.71 -bw_non_equal 0.73 -bw_pointer 0.7 -bw_positive 0.53 -bw_float 0.88 -bw_call 0.56 -bw_neg_return 0.68 -bw_null_return 0.39 -bw_const_return 0.98 -bw_loop_header 0.23 -bw_loop_branch 0.45 -bw_loop_exit 0.4')], [22, 71, 73, 70, 53, 88, 56, 68, 39, 98, 23, 45, 40]);
is(ecc_args(0.01, 1, 19, 95, 59, 27, 92, 77, 43, 42, 93, 96, 4, 65),
'-bt 0.01 -bw_noreturn 0.19 -bw_non_equal 0.95 -bw_pointer 0.59 -bw_positive 0.27 -bw_float 0.92 -bw_call 0.77 -bw_neg_return 0.43 -bw_null_return 0.42 -bw_const_return 0.93 -bw_loop_header 0.96 -bw_loop_branch 0.04 -bw_loop_exit 0.65');
is_deeply([parse_args(0.01, '-bt 0.01 -bw_noreturn 0.19 -bw_non_equal 0.95 -bw_pointer 0.59 -bw_positive 0.27 -bw_float 0.92 -bw_call 0.77 -bw_neg_return 0.43 -bw_null_return 0.42 -bw_const_return 0.93 -bw_loop_header 0.96 -bw_loop_branch 0.04 -bw_loop_exit 0.65')], [1, 19, 95, 59, 27, 92, 77, 43, 42, 93, 96, 4, 65]);
is(ecc_args(0.01, 53, 38, 4, 44, 3, 64, 58, 53, 74, 33, 49, 60, 31),
'-bt 0.53 -bw_noreturn 0.38 -bw_non_equal 0.04 -bw_pointer 0.44 -bw_positive 0.03 -bw_float 0.64 -bw_call 0.58 -bw_neg_return 0.53 -bw_null_return 0.74 -bw_const_return 0.33 -bw_loop_header 0.49 -bw_loop_branch 0.6 -bw_loop_exit 0.31');
is_deeply([parse_args(0.01, '-bt 0.53 -bw_noreturn 0.38 -bw_non_equal 0.04 -bw_pointer 0.44 -bw_positive 0.03 -bw_float 0.64 -bw_call 0.58 -bw_neg_return 0.53 -bw_null_return 0.74 -bw_const_return 0.33 -bw_loop_header 0.49 -bw_loop_branch 0.6 -bw_loop_exit 0.31')], [53, 38, 4, 44, 3, 64, 58, 53, 74, 33, 49, 60, 31]);
is(ecc_args(0.01, 56, 5, 90, 58, 51, 57, 2, 6, 79, 29, 42, 97, 65),
'-bt 0.56 -bw_noreturn 0.05 -bw_non_equal 0.9 -bw_pointer 0.58 -bw_positive 0.51 -bw_float 0.57 -bw_call 0.02 -bw_neg_return 0.06 -bw_null_return 0.79 -bw_const_return 0.29 -bw_loop_header 0.42 -bw_loop_branch 0.97 -bw_loop_exit 0.65');
is_deeply([parse_args(0.01, '-bt 0.56 -bw_noreturn 0.05 -bw_non_equal 0.9 -bw_pointer 0.58 -bw_positive 0.51 -bw_float 0.57 -bw_call 0.02 -bw_neg_return 0.06 -bw_null_return 0.79 -bw_const_return 0.29 -bw_loop_header 0.42 -bw_loop_branch 0.97 -bw_loop_exit 0.65')], [56, 5, 90, 58, 51, 57, 2, 6, 79, 29, 42, 97, 65]);
is(ecc_args(0.01, 50, 33, 12, 30, 59, 65, 51, 73, 56, 63, 75, 46, 80),
'-bt 0.5 -bw_noreturn 0.33 -bw_non_equal 0.12 -bw_pointer 0.3 -bw_positive 0.59 -bw_float 0.65 -bw_call 0.51 -bw_neg_return 0.73 -bw_null_return 0.56 -bw_const_return 0.63 -bw_loop_header 0.75 -bw_loop_branch 0.46 -bw_loop_exit 0.8');
is_deeply([parse_args(0.01, '-bt 0.5 -bw_noreturn 0.33 -bw_non_equal 0.12 -bw_pointer 0.3 -bw_positive 0.59 -bw_float 0.65 -bw_call 0.51 -bw_neg_return 0.73 -bw_null_return 0.56 -bw_const_return 0.63 -bw_loop_header 0.75 -bw_loop_branch 0.46 -bw_loop_exit 0.8')], [50, 33, 12, 30, 59, 65, 51, 73, 56, 63, 75, 46, 80]);
is(ecc_args(0.01, 78, 68, 12, 24, 42, 57, 12, 75, 37, 23, 41, 28, 77),
'-bt 0.78 -bw_noreturn 0.68 -bw_non_equal 0.12 -bw_pointer 0.24 -bw_positive 0.42 -bw_float 0.57 -bw_call 0.12 -bw_neg_return 0.75 -bw_null_return 0.37 -bw_const_return 0.23 -bw_loop_header 0.41 -bw_loop_branch 0.28 -bw_loop_exit 0.77');
is_deeply([parse_args(0.01, '-bt 0.78 -bw_noreturn 0.68 -bw_non_equal 0.12 -bw_pointer 0.24 -bw_positive 0.42 -bw_float 0.57 -bw_call 0.12 -bw_neg_return 0.75 -bw_null_return 0.37 -bw_const_return 0.23 -bw_loop_header 0.41 -bw_loop_branch 0.28 -bw_loop_exit 0.77')], [78, 68, 12, 24, 42, 57, 12, 75, 37, 23, 41, 28, 77]);
is(ecc_args(0.01, 78, 79, 52, 50, 5, 69, 51, 74, 64, 9, 74, 27, 67),
'-bt 0.78 -bw_noreturn 0.79 -bw_non_equal 0.52 -bw_pointer 0.5 -bw_positive 0.05 -bw_float 0.69 -bw_call 0.51 -bw_neg_return 0.74 -bw_null_return 0.64 -bw_const_return 0.09 -bw_loop_header 0.74 -bw_loop_branch 0.27 -bw_loop_exit 0.67');
is_deeply([parse_args(0.01, '-bt 0.78 -bw_noreturn 0.79 -bw_non_equal 0.52 -bw_pointer 0.5 -bw_positive 0.05 -bw_float 0.69 -bw_call 0.51 -bw_neg_return 0.74 -bw_null_return 0.64 -bw_const_return 0.09 -bw_loop_header 0.74 -bw_loop_branch 0.27 -bw_loop_exit 0.67')], [78, 79, 52, 50, 5, 69, 51, 74, 64, 9, 74, 27, 67]);
is(ecc_args(0.01, 41, 19, 33, 52, 4, 19, 21, 68, 22, 58, 2, 72, 96),
'-bt 0.41 -bw_noreturn 0.19 -bw_non_equal 0.33 -bw_pointer 0.52 -bw_positive 0.04 -bw_float 0.19 -bw_call 0.21 -bw_neg_return 0.68 -bw_null_return 0.22 -bw_const_return 0.58 -bw_loop_header 0.02 -bw_loop_branch 0.72 -bw_loop_exit 0.96');
is_deeply([parse_args(0.01, '-bt 0.41 -bw_noreturn 0.19 -bw_non_equal 0.33 -bw_pointer 0.52 -bw_positive 0.04 -bw_float 0.19 -bw_call 0.21 -bw_neg_return 0.68 -bw_null_return 0.22 -bw_const_return 0.58 -bw_loop_header 0.02 -bw_loop_branch 0.72 -bw_loop_exit 0.96')], [41, 19, 33, 52, 4, 19, 21, 68, 22, 58, 2, 72, 96]);
is(ecc_args(0.01, 12, 17, 77, 2, 60, 62, 39, 0, 7, 47, 50, 71, 48),
'-bt 0.12 -bw_noreturn 0.17 -bw_non_equal 0.77 -bw_pointer 0.02 -bw_positive 0.6 -bw_float 0.62 -bw_call 0.39 -bw_neg_return 0 -bw_null_return 0.07 -bw_const_return 0.47 -bw_loop_header 0.5 -bw_loop_branch 0.71 -bw_loop_exit 0.48');
is_deeply([parse_args(0.01, '-bt 0.12 -bw_noreturn 0.17 -bw_non_equal 0.77 -bw_pointer 0.02 -bw_positive 0.6 -bw_float 0.62 -bw_call 0.39 -bw_neg_return 0 -bw_null_return 0.07 -bw_const_return 0.47 -bw_loop_header 0.5 -bw_loop_branch 0.71 -bw_loop_exit 0.48')], [12, 17, 77, 2, 60, 62, 39, 0, 7, 47, 50, 71, 48]);
is(ecc_args(0.01, 33, 40, 74, 13, 52, 87, 87, 0, 29, 14, 32, 87, 22),
'-bt 0.33 -bw_noreturn 0.4 -bw_non_equal 0.74 -bw_pointer 0.13 -bw_positive 0.52 -bw_float 0.87 -bw_call 0.87 -bw_neg_return 0 -bw_null_return 0.29 -bw_const_return 0.14 -bw_loop_header 0.32 -bw_loop_branch 0.87 -bw_loop_exit 0.22');
is_deeply([parse_args(0.01, '-bt 0.33 -bw_noreturn 0.4 -bw_non_equal 0.74 -bw_pointer 0.13 -bw_positive 0.52 -bw_float 0.87 -bw_call 0.87 -bw_neg_return 0 -bw_null_return 0.29 -bw_const_return 0.14 -bw_loop_header 0.32 -bw_loop_branch 0.87 -bw_loop_exit 0.22')], [33, 40, 74, 13, 52, 87, 87, 0, 29, 14, 32, 87, 22]);
is(ecc_args(0.01, 4, 91, 32, 92, 46, 39, 8, 5, 18, 49, 22, 52, 84),
'-bt 0.04 -bw_noreturn 0.91 -bw_non_equal 0.32 -bw_pointer 0.92 -bw_positive 0.46 -bw_float 0.39 -bw_call 0.08 -bw_neg_return 0.05 -bw_null_return 0.18 -bw_const_return 0.49 -bw_loop_header 0.22 -bw_loop_branch 0.52 -bw_loop_exit 0.84');
is_deeply([parse_args(0.01, '-bt 0.04 -bw_noreturn 0.91 -bw_non_equal 0.32 -bw_pointer 0.92 -bw_positive 0.46 -bw_float 0.39 -bw_call 0.08 -bw_neg_return 0.05 -bw_null_return 0.18 -bw_const_return 0.49 -bw_loop_header 0.22 -bw_loop_branch 0.52 -bw_loop_exit 0.84')], [4, 91, 32, 92, 46, 39, 8, 5, 18, 49, 22, 52, 84]);
is(ecc_args(0.01, 99, 17, 84, 80, 65, 42, 12, 19, 64, 62, 85, 27, 6),
'-bt 0.99 -bw_noreturn 0.17 -bw_non_equal 0.84 -bw_pointer 0.8 -bw_positive 0.65 -bw_float 0.42 -bw_call 0.12 -bw_neg_return 0.19 -bw_null_return 0.64 -bw_const_return 0.62 -bw_loop_header 0.85 -bw_loop_branch 0.27 -bw_loop_exit 0.06');
is_deeply([parse_args(0.01, '-bt 0.99 -bw_noreturn 0.17 -bw_non_equal 0.84 -bw_pointer 0.8 -bw_positive 0.65 -bw_float 0.42 -bw_call 0.12 -bw_neg_return 0.19 -bw_null_return 0.64 -bw_const_return 0.62 -bw_loop_header 0.85 -bw_loop_branch 0.27 -bw_loop_exit 0.06')], [99, 17, 84, 80, 65, 42, 12, 19, 64, 62, 85, 27, 6]);
is(ecc_args(0.01, 56, 56, 11, 21, 49, 5, 5, 5, 4, 27, 47, 45, 20),
'-bt 0.56 -bw_noreturn 0.56 -bw_non_equal 0.11 -bw_pointer 0.21 -bw_positive 0.49 -bw_float 0.05 -bw_call 0.05 -bw_neg_return 0.05 -bw_null_return 0.04 -bw_const_return 0.27 -bw_loop_header 0.47 -bw_loop_branch 0.45 -bw_loop_exit 0.2');
is_deeply([parse_args(0.01, '-bt 0.56 -bw_noreturn 0.56 -bw_non_equal 0.11 -bw_pointer 0.21 -bw_positive 0.49 -bw_float 0.05 -bw_call 0.05 -bw_neg_return 0.05 -bw_null_return 0.04 -bw_const_return 0.27 -bw_loop_header 0.47 -bw_loop_branch 0.45 -bw_loop_exit 0.2')], [56, 56, 11, 21, 49, 5, 5, 5, 4, 27, 47, 45, 20]);
is(ecc_args(0.01, 5, 97, 48, 63, 64, 94, 7, 30, 63, 4, 48, 0, 94),
'-bt 0.05 -bw_noreturn 0.97 -bw_non_equal 0.48 -bw_pointer 0.63 -bw_positive 0.64 -bw_float 0.94 -bw_call 0.07 -bw_neg_return 0.3 -bw_null_return 0.63 -bw_const_return 0.04 -bw_loop_header 0.48 -bw_loop_branch 0 -bw_loop_exit 0.94');
is_deeply([parse_args(0.01, '-bt 0.05 -bw_noreturn 0.97 -bw_non_equal 0.48 -bw_pointer 0.63 -bw_positive 0.64 -bw_float 0.94 -bw_call 0.07 -bw_neg_return 0.3 -bw_null_return 0.63 -bw_const_return 0.04 -bw_loop_header 0.48 -bw_loop_branch 0 -bw_loop_exit 0.94')], [5, 97, 48, 63, 64, 94, 7, 30, 63, 4, 48, 0, 94]);
is(ecc_args(0.01, 25, 75, 0, 26, 97, 86, 31, 67, 13, 99, 59, 58, 77),
'-bt 0.25 -bw_noreturn 0.75 -bw_non_equal 0 -bw_pointer 0.26 -bw_positive 0.97 -bw_float 0.86 -bw_call 0.31 -bw_neg_return 0.67 -bw_null_return 0.13 -bw_const_return 0.99 -bw_loop_header 0.59 -bw_loop_branch 0.58 -bw_loop_exit 0.77');
is_deeply([parse_args(0.01, '-bt 0.25 -bw_noreturn 0.75 -bw_non_equal 0 -bw_pointer 0.26 -bw_positive 0.97 -bw_float 0.86 -bw_call 0.31 -bw_neg_return 0.67 -bw_null_return 0.13 -bw_const_return 0.99 -bw_loop_header 0.59 -bw_loop_branch 0.58 -bw_loop_exit 0.77')], [25, 75, 0, 26, 97, 86, 31, 67, 13, 99, 59, 58, 77]);
is(ecc_args(0.01, 70, 35, 2, 44, 31, 38, 53, 2, 93, 36, 33, 14, 92),
'-bt 0.7 -bw_noreturn 0.35 -bw_non_equal 0.02 -bw_pointer 0.44 -bw_positive 0.31 -bw_float 0.38 -bw_call 0.53 -bw_neg_return 0.02 -bw_null_return 0.93 -bw_const_return 0.36 -bw_loop_header 0.33 -bw_loop_branch 0.14 -bw_loop_exit 0.92');
is_deeply([parse_args(0.01, '-bt 0.7 -bw_noreturn 0.35 -bw_non_equal 0.02 -bw_pointer 0.44 -bw_positive 0.31 -bw_float 0.38 -bw_call 0.53 -bw_neg_return 0.02 -bw_null_return 0.93 -bw_const_return 0.36 -bw_loop_header 0.33 -bw_loop_branch 0.14 -bw_loop_exit 0.92')], [70, 35, 2, 44, 31, 38, 53, 2, 93, 36, 33, 14, 92]);
is(ecc_args(0.01, 78, 23, 59, 78, 4, 29, 29, 96, 28, 46, 59, 19, 33),
'-bt 0.78 -bw_noreturn 0.23 -bw_non_equal 0.59 -bw_pointer 0.78 -bw_positive 0.04 -bw_float 0.29 -bw_call 0.29 -bw_neg_return 0.96 -bw_null_return 0.28 -bw_const_return 0.46 -bw_loop_header 0.59 -bw_loop_branch 0.19 -bw_loop_exit 0.33');
is_deeply([parse_args(0.01, '-bt 0.78 -bw_noreturn 0.23 -bw_non_equal 0.59 -bw_pointer 0.78 -bw_positive 0.04 -bw_float 0.29 -bw_call 0.29 -bw_neg_return 0.96 -bw_null_return 0.28 -bw_const_return 0.46 -bw_loop_header 0.59 -bw_loop_branch 0.19 -bw_loop_exit 0.33')], [78, 23, 59, 78, 4, 29, 29, 96, 28, 46, 59, 19, 33]);
is(ecc_args(0.01, 49, 87, 42, 11, 40, 27, 63, 15, 66, 76, 58, 38, 62),
'-bt 0.49 -bw_noreturn 0.87 -bw_non_equal 0.42 -bw_pointer 0.11 -bw_positive 0.4 -bw_float 0.27 -bw_call 0.63 -bw_neg_return 0.15 -bw_null_return 0.66 -bw_const_return 0.76 -bw_loop_header 0.58 -bw_loop_branch 0.38 -bw_loop_exit 0.62');
is_deeply([parse_args(0.01, '-bt 0.49 -bw_noreturn 0.87 -bw_non_equal 0.42 -bw_pointer 0.11 -bw_positive 0.4 -bw_float 0.27 -bw_call 0.63 -bw_neg_return 0.15 -bw_null_return 0.66 -bw_const_return 0.76 -bw_loop_header 0.58 -bw_loop_branch 0.38 -bw_loop_exit 0.62')], [49, 87, 42, 11, 40, 27, 63, 15, 66, 76, 58, 38, 62]);
