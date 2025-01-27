using Clang.Generators

cd(@__DIR__)

#=
commit daed8f8a498bd928cc63ceab83e9c4be0a1628f6 (HEAD, tag: v2.2)
Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue Oct 22 10:18:48 2024 +0200
=#

include_dir = expanduser("~/opt/libgpiod/include")
options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, "-I$include_dir")

headers = joinpath(include_dir,"gpiod.h")
ctx = create_context(headers, args, options)

build!(ctx)
