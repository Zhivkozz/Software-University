﻿using PlayersAndMonsters.Core.Factories.Contracts;
using PlayersAndMonsters.Models.Cards.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace PlayersAndMonsters.Core.Factories.Factories
{
    public class CardFactory : ICardFactory
    {
        public ICard CreateCard(string type, string name)
        {
            Type card = Assembly.GetExecutingAssembly().GetTypes().FirstOrDefault(n => n.Name == type + "Card");

            return (ICard)Activator.CreateInstance(card, name);
        }
    }
}