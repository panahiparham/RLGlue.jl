
"""
Interaction - a struct to hold the results of an interaction with the environment

    o::Any - observation
    a::Union{Int, Nothing} - action
    t::Bool - terminal
    r::Float64 - reward
    extra::Dict{String, Any} - extra information
"""
struct Interaction
    o::Any
    a::Union{Int, Nothing}
    t::Bool
    r::Float64
    extra::Dict{String, Any}
end


"""
Glue - a struct to hold the RL-Glue information

    environment::BaseEnvironment
    agent::BaseAgent

    last_action::Union{Int, Nothing}
    total_reward::Float64
    num_steps::Int
    total_steps::Int
    num_episodes::Int
"""
mutable struct Glue
    environment::BaseEnvironment
    agent::BaseAgent

    last_action::Union{Int, Nothing}
    total_reward::Float64
    num_steps::Int
    total_steps::Int
    num_episodes::Int


    function Glue(environment::BaseEnvironment, agent::BaseAgent)
        return new(environment, agent, nothing, 0.0, 0, 0, 0)
    end 
end



"""
    start!(glue::Glue) -> (s, a)::Tuple{Any, Union{Int, Nothing}}
"""
function start!(glue::Glue)
    glue.num_steps = 0
    glue.total_reward = 0.0

    s = start!(glue.environment)
    glue.last_action = start!(glue.agent, s)


    return (s, glue.last_action)
end


"""
    step!(glue::Glue) -> interaction::Interaction
"""
function step!(glue::Glue)
    @assert glue.last_action !== nothing "Action is nothing; make sure to call start!(glue) before calling step!(glue)"

    (reward, s, term, extra) = step!(glue.environment, glue.last_action)

    glue.total_reward += reward
    glue.num_steps += 1
    glue.total_steps += 1
    if term
        glue.num_episodes += 1
        end!(glue.agent, reward, extra)
        return Interaction(s, nothing, term, reward, extra)
    end

    glue.last_action = step!(glue.agent, reward, s, extra)
    return Interaction(s, glue.last_action, term, reward, extra)
    
end


"""
    runEpisode!(glue::Glue, max_steps::Int = 0) -> is_terminal::Bool
"""
function runEpisode!(glue::Glue, max_steps::Int = 0)
    is_terminal = false

    start!(glue)

    while (!is_terminal) && ((max_steps == 0) || (glue.num_steps < max_steps))
        rl_step_result = step!(glue)
        is_terminal = rl_step_result.t
    end

    # even episode cutoff counts as completing an episode

    if !is_terminal
        glue.num_episodes += 1
    end

    return is_terminal
end