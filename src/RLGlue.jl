module RLGlue

greet() = print("Hello RLGlue!")


export 
    BaseEnvironment,
    start!,
    step!
include("environment.jl")

export 
    BaseAgent,
    start!,
    step!,
    end!
include("agent.jl")


export
    Interaction,
    Glue,
    start!,
    step!,
    runEpisode!
include("glue.jl")



end # module RLGlue
