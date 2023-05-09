
using Random
using RLGlue


module MountainCarConst
const vel_limit = (-0.07f0, 0.07f0)
const pos_limit = (-1.2f0, 0.5f0)
const pos_initial_range = (-0.6f0, 0.4f0)

const Reverse=1
const Neutral=2
const Accelerate=3
end

"""
    MountainCar
"""
mutable struct MountainCar <: RLGlue.BaseEnvironment
    pos::Float32
    vel::Float32
    actions::Vector{Int}
    function MountainCar(pos=0.0f0, vel=0.0f0)
        mcc = MountainCarConst
        @boundscheck (pos >= mcc.pos_limit[1] && pos <= mcc.pos_limit[2])
        @boundscheck (vel >= mcc.vel_limit[1] && vel <= mcc.vel_limit[2])
        actions = [mcc.Reverse, mcc.Neutral, mcc.Accelerate]
        new(pos, vel, actions)
    end
end

function RLGlue.start!(env::MountainCar)
    env.pos = (rand()*(MountainCarConst.pos_initial_range[2]
                          - MountainCarConst.pos_initial_range[1])
               + MountainCarConst.pos_initial_range[1])

    env.vel = 0.0

    return [env.pos, env.vel]
end


function RLGlue.step!(env::MountainCar, action::Int)
    @assert action in env.actions "Invalid action: $action"

    env.vel = clamp(env.vel + (action - 2)*0.001 - 0.0025*cos(3*env.pos), MountainCarConst.vel_limit...)
    env.pos = clamp(env.pos + env.vel, MountainCarConst.pos_limit...)

    o = [env.pos, env.vel]
    r = env.pos >= MountainCarConst.pos_limit[2] ? 0.0 : -1.0
    t = env.pos >= MountainCarConst.pos_limit[2]

    return (r, o, t, Dict{String, Any}())
end
