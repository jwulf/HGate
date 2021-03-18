using Microsoft.Quantum.Simulation.Simulators;

namespace JoshWulf.Quantum.Hgate
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                var count = 10000;

                var res = QBitRead.Run(sim, count).Result;
                var (numTails, numHeads) = res;
                System.Console.WriteLine($"QBitRead \t\t Tails={numTails,0} \t Heads={numHeads,0}");

                res = CoinFlip.Run(sim, count).Result;
                (numTails, numHeads) = res;
                System.Console.WriteLine($"CoinFlip \t\t Tails={numTails,0} \t Heads={numHeads,0}");

                res = DoubleCoinFlip.Run(sim, count).Result;
                (numTails, numHeads) = res;
                System.Console.WriteLine($"DoubleCoinFlip \t\t Tails={numTails,0} \t Heads={numHeads,0}");

                res = BlindDoubleCoinFlip.Run(sim, count).Result;
                (numTails, numHeads) = res;
                System.Console.WriteLine($"BlindDoubleCoinFlip \t Tails={numTails,0} \t Heads={numHeads,0}");

                res = BlindDoubleCoinFlip2.Run(sim, count).Result;
                (numTails, numHeads) = res;
                System.Console.WriteLine($"BlindDoubleCoinFlip2 \t Tails={numTails,0} \t Heads={numHeads,0}");
            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
    }
}
