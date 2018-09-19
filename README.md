# Hadamard Gate Q# Demo

This Q# Project is a basic project that demonstrates a counter-intuitive quantum behaviour using a [Hadamard gate](https://en.wikipedia.org/wiki/Hadamard_transform#Quantum_computing_applications).

I wrote this after attending a Q# workshop lead by [John Azariah](https://ndcsydney.com/speaker/john-azariah) at NDC Sydney 2018, and hearing him describe this behaviour.

To run it on my computer, with the [Microsoft Q# SDK](https://docs.microsoft.com/en-us/quantum/quantum-installconfig?view=qsharp-preview) installed, I run:

```
dotnet restore
dotnet run
```

You should see an output like this:

```
QBitRead                 0s=10000        1s=0
CoinFlip                 0s=4919         1s=5081
DoubleCoinFlip           0s=5023         1s=4977
BlindDoubleCoinFlip      0s=10000        1s=0
Press any key to continue...
```

## Explanation

A qubit can be in a Zero or One position, just like a classical bit. Unlike a classical bit, however, a qubit can also be in a _superposition_.

In a superposition, a qubit (and you've got to imagine this - it's a model) is somewhere on the surface of a hyper-dimensional sphere, where the North and South poles of the sphere are One and Zero, and every other position represents a probability. The equator of the sphere is a 50% probability of either One or Zero. Locations north of the equator represent greater probabilities of One, increasing as you go further north up to 100% when you hit the North pole. Locations south of the equator represent greater probabilities of Zero, increasing as you go further south up to 100% when you hit the South pole.

The probability is collapsed into an actual value as soon as the state of the qubit is observed (the measure operation `M()` in Q#). You can measure the percentage of the probability by doing the same operation one hundred times, and totalling the outcomes.

In classical computers, logic gates shift the state of classical bits between One and Zero. In quantum computers, quantum logic gates shift the position of a qubit on this hyperdimensional sphere, changing the probability of its eventual value when it is observed.

The Hadamard Gate, or H Gate, is a basic quantum logic gate. When applied to a qubit that is located on one of the poles - a solid One or Zero - it moves the qubit to the equator of the the hypersphere. This gives the qubit a 50% probability of now being either a Zero or a One.

The "BitRead" operation in this project does 10,000 reads of a qubit set to Zero. As you would expect, this returns 10,000 Zeros.

```
QBitRead                 0s=10000        1s=0
```

The "CoinFlip" operation in this project demonstrates the action of the H Gate. A qubit is set to Zero and passed through the H Gate, and its state examined, 10,000 times. This produces a pretty clear 50-50 distribution - resulting in 5000 Ones and 5000 Zeros, +- ~3%.

```
CoinFlip                 0s=5026         1s=4974
```

In the "DoubleCoinFlip" operation, we set the qubit to Zero and pass it through the H Gate. We then examine its state. We then pass it through the H Gate again, and again examine its state, and total the results of this observation. In this case we see the same 50-50 distribution. That's what we'd expect - both Ones and Zeros are sent to the equator of the hypersphere, so no matter which of the two states - One or Zero - the qubit has when it enters the H Gate in the second pass, it is again "shuffled" with the same probability.

```
DoubleCoinFlip           0s=4970         1s=5030
```

Now here is where it gets quantum weird.

In the "BlindDoubleCoinFlip" operation, we do exactly the same thing as the DoubleCoinFlip - _with one exception_. We don't examine the state of the qubit after the first pass through the gate. We only observe it after it has been through the gate twice.

In this case, when we look at the qubit it is Zero.

Every. Single. Time.

```
BlindDoubleCoinFlip      0s=10000        1s=0
```

What????

To get some idea of what is happening here, we have to look at another way of modelling the complex hyperspace that the qubit operates in. If you imagine the hypersphere instead as a flat circle, again with One at the top, and Zero at the bottom, then the translation of the qubit from the pole to the equator is a reflection around a line at 45 degrees to the starting position of the qubit.

It turns out that this is accurate, because qubits that start at positions other than Zero or One can be measured through indirect means to demonstrate that the H Gate does such a transformation.

Now, because the qubit did not collapse from its probablistic hyperspace to real space after the first pass through the gate - because we did not observe it - the translation of the second H Gate translated it from 50% probability (the equator) to 100% (the pole). Thus when we observed it, there was no shift in its real value, because there was no shift in its hyperspace probabililty value. We get 10,000 Zeros.

The H Gate does not move the qubit in real space. It moves it in a complex hyperspace that intersects with the real space of our experience in a way that causes the particle to appear when observe, and determines what it is when it is observed. That hyperspace can be modelled mathematically, and in the mathematical models it is multi-dimensional, and has coordinates that have complex numbers that involve the square root of -1. Moving the particle in that hyperspace, when no-one is watching it, causes the probability of what attributes of the particle are to change in real space when someone next looks at it.

That's pretty weird.

You might be wondering why the qubit collapses back to Zero every time in the BlindDoubleCoinFlip. That's because the H gate moves the probability of its value, not its value. The value is always set, 100%, when we look at it. The first pass through the H Gate set the probability of its value to 50-50. The second pass through the H Gate set it to 100%. So there is no "collapse of the waveform" when we look at it after the second pass, and thus no change in value.

It's unresolved for me how the Hamard *really* works. The two models of the hypersphere with the rotational translation and the circle with the reflection translation are useful for visualising what is going on, but really you need the maths to truly get it. The analogy does break down when you try to imagine the second H Gate pass reflecting the probability around a line at 45 degrees to the midpoint, or continuing another 90 degree rotation. That would have the particle deterministically flip its value after two passes, which is clearly not what happens.

Anyway, this is a small demo of the Q# SDK and some counter-intuitive quantum behaviour!
