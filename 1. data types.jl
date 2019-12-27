a = []                      # 0-element Array{Any,1}

b = Float32[]               # 0-element Array{Float32,1}

x = 1 + 2                   # 3
y = 1 + 2.                  # 3.0

x == y                      # true


#=
`::` is used to attach type annotations to expressions and variables (also called declaration).
There are two reasons to do this:
    1. As an assertion to confirm the program works as expected
    2. To provide extra type info to the compiler, which may improve performance.
=#

x::Int                      # 3
x::Float32                  # TypeError: in typeassert, expected Float32, got Int64
y::Int                      # TypeError: in typeassert, expected Int64, got Float64
y::Float64                  # 3.0

# pre-declaring a variable data type only works for local variables
local z::Int8 = 1 + 2       # 3
z                           # UndefVarError: z not defined
z::Int8 = 1 + 2             # syntax: type declarations on global variables are not yet supported

# Declarations can be attached to functions
function foo()::Float32
    return 3
end

f = foo()                   # 3.0f0
f::Float32                  # 3.0f0
f == x == y                 # true

function bar()::Float32
    z::Float32 = 5 + 1.9
    return z
end

b = bar()                   #6.9f0


#=
`<:` is used to say "is a subtype of", to show if the left side is a subtype of the
right side.
=#

Integer <: Number           # true
x <: Number                 # TypeError: in <:, expected Type, got Int64
typeof(x) <: Number         # true

function add(val1::Int, val2::Int)
    return val1 + val2
end

combined = add(10, 20)      # 30
typeof(combined)            # Int64
add(1.4, 2)                 # MethodError: no method matching add(::Float64, ::Int64)


#=
`struct` is like an object in python, with named fields and an instance.  However,
it cannot contain functions like python.  There are immutable `struct` and mutable
`mutable struct` types.
=#

struct Foo
    var1
    var2::Int
    var3::Float32
end

foo = Foo("Hello", 1, 6.9)  # Foo("Hello there", 1, 6.9f0)
foo.var1                    # "Hello"
typeof(foo.var1)            # String
fieldnames(Foo)             # (:var1, :var2, :var3)

mutable struct Bar
    var1
    var2::Float64
end

bar = Bar("ABC", 2/3)       # Bar("ABC", 0.6666666666666666)
bar.var2 = 1.5
bar                         # Bar("ABC", 1.5)
