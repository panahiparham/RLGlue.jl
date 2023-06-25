using RLGlue

include("mountainCar.jl")
include("random_agent.jl")


function main()

    env::MountainCar = MountainCar()
    agent::RandomAgent = RandomAgent(length(env.actions))


    glue::Glue = Glue(env, agent)

    
    o, a = start!(glue)
    println("o: $(o) a: $(a)")

    done = false
    time = 0
    while !done
        time += 1
        interaction = step!(glue)

        if interaction.r == 0
            done = true
        end

        println("o: $(interaction.o) a: $(interaction.a) r: $(interaction.r) t: $(interaction.t), time: $(time)")
    end


end

main()