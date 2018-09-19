using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace HGate
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                var count = 10000;

                var res = QBitRead.Run(sim, count).Result;
                var (numZeros, numOnes) = res;
                System.Console.WriteLine($"QBitRead \t\t 0s={numZeros,0} \t 1s={numOnes,0}");

                res = CoinFlip.Run(sim, count).Result;
                (numZeros, numOnes) = res;
                System.Console.WriteLine($"CoinFlip \t\t 0s={numZeros,0} \t 1s={numOnes,0}");

                res = DoubleCoinFlip.Run(sim, count).Result;
                (numZeros, numOnes) = res;
                System.Console.WriteLine($"DoubleCoinFlip \t\t 0s={numZeros,0} \t 1s={numOnes,0}");

                res = BlindDoubleCoinFlip.Run(sim, count).Result;
                (numZeros, numOnes) = res;
                System.Console.WriteLine($"BlindDoubleCoinFlip \t 0s={numZeros,0} \t 1s={numOnes,0}");

            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
    }
}