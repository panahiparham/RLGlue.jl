


abstract type BaseAgent end


"""
    start!(agent::BaseAgent, observation::Any) -> action (Int)
"""
function start!(agent::BaseAgent, observation::Any)
    @error "Implement start! for $(typeof(agent))"
end


"""
    step!(agent::BaseAgent, reward::Float64, observation::Any, extra::Dict{String, Any}) -> action (Int)
"""
function step!(agent::BaseAgent, reward::Float64, observation::Any, extra::Dict{String, Any})
    @error "Implement step! for $(typeof(agent))"
end


"""
    end!(agent::AbstrtactAgent, reward::Float64, extra::Dict{String, Any}) -> nothing
"""
function end!(agent::BaseAgent, reward::Float64, extra::Dict{String, Any})
    @error "Implement end! for $(typeof(agent))"
end