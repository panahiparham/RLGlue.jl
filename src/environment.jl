


abstract type BaseEnvironment end


"""
    start!(env::BaseEnvironment) -> observation::Any
"""
function start!(env::BaseEnvironment)
    @error "Implement start! for $(typeof(env))"
end


"""
    step!(env::BaseEnvironment, action::Int) -> (r, o, t, extra) Tuple{Float64, Any, Bool, Dict{String, Any}}
"""
function step!(env::BaseEnvironment, action::Int)
    @error "Implement step! for $(typeof(env))"
end