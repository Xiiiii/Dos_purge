using System;
using System.Collections.Generic;
using System.Linq;

namespace ConsoleApplication1
{
	class Program
	{
		static void Main(string[] args)
		{
			if (args.Length != 1)
			{
				Console.WriteLine("syntax: GetQVHash.exe <list of extraction Id separated with commas>");
				return;
			}

			List<string> valuesList = args[0].Split(',').ToList();
			valuesList.Sort();

			string result = String.Format("{0:X}", string.Join("_", valuesList).GetHashCode());
			Console.WriteLine(result);
		}
	}
}
