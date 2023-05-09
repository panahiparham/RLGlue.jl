using Random
using RLGlue


struct RandomAgent <: RLGlue.BaseAgent
    num_actions::Int
    function RandomAgent(num_actions::Int)
        new(num_actions)
    end
end

function RLGlue.start!(agent::RandomAgent, observation::Any)
    return rand(1:agent.num_actions)
end

function RLGlue.step!(agent::RandomAgent, reward::Float64, observation::Any, extra::Dict{String, Any})
    return rand(1:agent.num_actions)
end

function RLGlue.end!(agent::RandomAgent, reward::Float64, extra::Dict{String, Any})
    return nothing
end