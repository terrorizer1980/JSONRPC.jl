using Test
using JSON
using JSONRPC
using JSONRPC: typed_res, @dict_readable, Outbound
using Sockets

@dict_readable struct Foo <: Outbound
    fieldA::Int
    fieldB::String
    fieldC::Union{Missing,String}
    fieldD::Union{String,Missing}
end

@testset "JSONRPC" begin
    include("test_interface_def.jl")
    include("test_typed.jl")

    @testset "check response type" begin
        @test typed_res(nothing, Nothing) isa Nothing
        @test typed_res([1,"2",3], Vector{Any}) isa Vector{Any}
        @test typed_res([1,2,3], Vector{Int}) isa Vector{Int}
        @test typed_res([1,2,3], Vector{Float64}) isa Vector{Float64}
        @test typed_res(['f','o','o'], String) isa String
        @test typed_res("foo", String) isa String
    end
end
