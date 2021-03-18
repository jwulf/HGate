namespace JoshWulf.Quantum.Hgate {
    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


   operation Set (desired: Result, q1: Qubit) : Unit {
        let current = M(q1);
        if (desired != current)
        {
            X(q1); // Not gate
        }
    }

    // Here we set a q-bit to 0 and then measure its state
    // This proves that a q-bit set to zero is measured as zero
    operation QBitRead (iterations: Int) : (Int, Int) {
        mutable numHeads = 0; // 1
        mutable numTails = 0; // 0
        use qubit = Qubit[1] {      // Qubit in Zero state
            for test in 1..iterations {
                Set (Zero, qubit[0]);                // Set the qubit to Zero
                let state = M(qubit[0]);            // Measure the value of the q-bit
                if (state == Zero) {
                    set numTails = numTails + 1;
                }
                if (state == One) {
                    set numHeads = numHeads + 1;
                }
            }
            ResetAll(qubit);       // Reset the qubit
        }
        return (numTails, numHeads);
    }

    // Here we pass a q-bit set to zero through a Hadmard gate
    // This sets the q-bit to a zero or one state with a 50% probability
    operation CoinFlip (iterations: Int) : (Int, Int) {
        mutable numHeads = 0; // 1
        mutable numTails = 0; // 0
        use qubit = Qubit[1] {      // Qubit in Zero state
            for test in 1..iterations {
                Set (Zero, qubit[0]);                // Set the qubit to Zero
                H(qubit[0]);                        // Pass through Hadamard Gate - gives 50% probability
                let state = M(qubit[0]);            // Measure the value of the q-bit
                if (state == Zero) {
                    set numTails = numTails + 1;
                }
                if (state == One) {
                    set numHeads = numHeads + 1;
                }
            }
            ResetAll(qubit);       // Reset the qubit
        }
        return (numTails, numHeads);
    }

    // Here we pass a q-bit set to zero through a Hadamard gate, giving us a 50% probability of a one or zero state
    // on the other side. After measuring it, we pass it through the H-gate again.
    // On the other side of the second H-gate, we get a 50% distribution of one and zero.
    operation DoubleCoinFlip (iterations: Int) : (Int, Int) {
        mutable numHeads = 0; // 1
        mutable numTails = 0; // 0
        use qubit = Qubit[1] {                  // Get a single qubit
            for test in 1..iterations {
                Set (Zero, qubit[0]);                // Set the qubit to Zero
                H(qubit[0]);                        // Pass through Hadamard Gate - gives 50% probability
                let observation = M(qubit[0]);      // Measure the value of the q-bit
                H(qubit[0]);                        // Flip it again
                let state = M(qubit[0]);            // Measure the value of the q-bit
                if (state == Zero) {
                    set numTails = numTails + 1;
                }
                if (state == One) {
                    set numHeads = numHeads + 1;
                }
            }
            ResetAll(qubit);
        }
        return (numTails, numHeads); 
    }
    // Here we pass a q-bit set to zero through a Hadamard gate. On the other side we get a q-bit with a 50% probability of a 1 or 0 state.
    // However, we perform no measurement, and thus do not collapse the probability waveform.
    // We then pass it through a second Hadamard gate, and perform the measurement on the other side of that gate.
    operation BlindDoubleCoinFlip (iterations: Int) : (Int, Int) {
        mutable numHeads = 0; // 1
        mutable numTails = 0; // 0
        use qubit = Qubit[1] {                  // Get a single qubit
            for test in 1..iterations {
                Set (Zero, qubit[0]);                // Set the qubit to Zero
                H(qubit[0]);                        // Pass through Hadamard Gate - gives 50% probability
                H(qubit[0]);                        // Flip it again
                let state = M(qubit[0]);            // Measure the value of the q-bit
                if (state == Zero) {
                    set numTails = numTails + 1;
                }
                if (state == One) {
                    set numHeads = numHeads + 1;
                }
            }
            ResetAll(qubit);
        }
        return (numTails, numHeads);
    } 
}