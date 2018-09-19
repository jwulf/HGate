namespace HGate
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
            let current = M(q1);
            if (desired != current)
            {
                X(q1); // Not gate
            }
        }
    }

operation QBitRead (count: Int) : (Int, Int)
{
    body
    {
        mutable numOnes = 0;
        mutable numZeros = 0;
        using (qubit = Qubit[1]) {      // Qubit in Zero state
           for (test in 1..count) {
                Set (Zero, qubit[0]);                // Set the qubit to Zero
                let state = M(qubit[0]);            // Measure the value of the q-bit
                if (state == Zero) {
                   set numZeros = numZeros + 1;
                }
                if (state == One) {
                    set numOnes = numOnes + 1;
                }
            }
            ResetAll(qubit);       // Reset the qubit
        }
        return (numZeros, numOnes);
    }
}
    operation CoinFlip (count: Int) : (Int, Int)
    {
        body
        {
            mutable numOnes = 0;
            mutable numZeros = 0;
            using (qubit = Qubit[1]) {      // Qubit in Zero state
               for (test in 1..count) {
                    Set (Zero, qubit[0]);                // Set the qubit to Zero
                    H(qubit[0]);                        // Pass through Hadamard Gate - gives 50% probability
                    let state = M(qubit[0]);            // Measure the value of the q-bit
                    if (state == Zero) {
                       set numZeros = numZeros + 1;
                    }
                    if (state == One) {
                        set numOnes = numOnes + 1;
                    }
                }
                ResetAll(qubit);       // Reset the qubit
            }
            return (numZeros, numOnes);
        }
    }

    operation DoubleCoinFlip (count: Int) : (Int, Int)
    {
        body
        {
            mutable numOnes = 0;
            mutable numZeros = 0;
            using (qubit = Qubit[1]) {                  // Get a single qubit
                for (test in 1..count) {
                    Set (Zero, qubit[0]);                // Set the qubit to Zero
                    H(qubit[0]);                        // Pass through Hadamard Gate - gives 50% probability
                    let observation = M(qubit[0]);      // Measure the value of the q-bit
                    H(qubit[0]);                        // Flip it again
                    let state = M(qubit[0]);            // Measure the value of the q-bit
                    if (state == Zero) {
                        set numZeros = numZeros + 1;
                    }
                    if (state == One) {
                        set numOnes = numOnes + 1;
                    }
                }
                ResetAll(qubit);
            }
            return (numZeros, numOnes);
        }
    }

    operation BlindDoubleCoinFlip (count: Int) : (Int, Int)
    {
        body
        {
            mutable numOnes = 0;
            mutable numZeros = 0;
            using (qubit = Qubit[1]) {                  // Get a single qubit
                for (test in 1..count) {
                    Set (Zero, qubit[0]);                // Set the qubit to Zero
                    H(qubit[0]);                        // Pass through Hadamard Gate - gives 50% probability
                    H(qubit[0]);                        // Flip it again
                    let state = M(qubit[0]);            // Measure the value of the q-bit
                    if (state == Zero) {
                        set numZeros = numZeros + 1;
                    }
                    if (state == One) {
                        set numOnes = numOnes + 1;
                    }
                }
                ResetAll(qubit);
            }
            return (numZeros, numOnes);
        }
    }
}
