------------------------------------------------------------------------------
--  KrysioUI\Data\CooldownManager.lua
--  Blizzard Cooldown Manager layout strings
--
--  Tag format: classID * 10 + specIndex  (e.g. 11 = Warrior Arms,
--  111 = Druid Balance). specIndex is 1-based (GetSpecialization()).
------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI:SetProfileData("CooldownManager", {
    cdmData = {
        profileKeys = {
            -- Warrior (classID = 1)
            [11] = {
                ["KrysioUI - Arms"] = { profileKey = "KrysioUI - Arms", coloredName = "|cffc79c6eArms|r", icon = 12294 },
            },
            [12] = {
                ["KrysioUI - Fury"] = { profileKey = "KrysioUI - Fury", coloredName = "|cffc79c6eFury|r", icon = 20252 },
            },
            [13] = {
                ["KrysioUI - Protection"] = { profileKey = "KrysioUI - Protection", coloredName = "|cffc79c6eProtection|r", icon = 23922 },
            },

            -- Paladin (classID = 2)
            [21] = {
                ["KrysioUI - Holy"] = { profileKey = "KrysioUI - Holy", coloredName = "|cfff58cbaHoly|r", icon = 19750 },
            },
            [22] = {
                ["KrysioUI - Protection"] = { profileKey = "KrysioUI - Protection", coloredName = "|cfff58cbaProtection|r", icon = 23922 },
            },
            [23] = {
                ["KrysioUI - Retribution"] = { profileKey = "KrysioUI - Retribution", coloredName = "|cfff58cbaRetribution|r", icon = 184092 },
            },

            -- Hunter (classID = 3)
            [31] = {
                ["KrysioUI - BeastMastery"] = { profileKey = "KrysioUI - BeastMastery", coloredName = "|cffabd473Beast Mastery|r", icon = 19574 },
            },
            [32] = {
                ["KrysioUI - Marksmanship"] = { profileKey = "KrysioUI - Marksmanship", coloredName = "|cffabd473Marksmanship|r", icon = 193526 },
            },
            [33] = {
                ["KrysioUI - Survival"] = { profileKey = "KrysioUI - Survival", coloredName = "|cffabd473Survival|r", icon = 109259 },
            },

            -- Rogue (classID = 4)
            [41] = {
                ["KrysioUI - Assassination"] = { profileKey = "KrysioUI - Assassination", coloredName = "|cfffff569Assassination|r", icon = 1329 },
            },
            [42] = {
                ["KrysioUI - Outlaw"] = { profileKey = "KrysioUI - Outlaw", coloredName = "|cfffff569Outlaw|r", icon = 315508 },
            },
            [43] = {
                ["KrysioUI - Subtlety"] = { profileKey = "KrysioUI - Subtlety", coloredName = "|cfffff569Subtlety|r", icon = 121153 },
            },

            -- Priest (classID = 5)
            [51] = {
                ["KrysioUI - Discipline"] = { profileKey = "KrysioUI - Discipline", coloredName = "|cffffffffDiscipline|r", icon = 47540 },
            },
            [52] = {
                ["KrysioUI - Holy"] = { profileKey = "KrysioUI - Holy", coloredName = "|cffffffffHoly|r", icon = 19750 },
            },
            [53] = {
                ["KrysioUI - Shadow"] = { profileKey = "KrysioUI - Shadow", coloredName = "|cffffffffShadow|r", icon = 15407 },
            },

            -- Death Knight (classID = 6)
            [61] = {
                ["KrysioUI - Blood"] = { profileKey = "KrysioUI - Blood", coloredName = "|cffc41f3bBlood|r", icon = 195182 },
            },
            [62] = {
                ["KrysioUI - Frost"] = { profileKey = "KrysioUI - Frost", coloredName = "|cffc41f3bFrost|r", icon = 49184 },
            },
            [63] = {
                ["KrysioUI - Unholy"] = { profileKey = "KrysioUI - Unholy", coloredName = "|cffc41f3bUnholy|r", icon = 63560 },
            },

            -- Shaman (classID = 7)
            [71] = {
                ["KrysioUI - Elemental"] = { profileKey = "KrysioUI - Elemental", coloredName = "|cff0070deElemental|r", icon = 5143 },
            },
            [72] = {
                ["KrysioUI - Enhancement"] = { profileKey = "KrysioUI - Enhancement", coloredName = "|cff0070deEnhancement|r", icon = 19503 },
            },
            [73] = {
                ["KrysioUI - Restoration"] = { profileKey = "KrysioUI - Restoration", coloredName = "|cff0070deRestoration|r", icon = 8004 },
            },

            -- Mage (classID = 8)
            [81] = {
                ["KrysioUI - Arcane"] = { profileKey = "KrysioUI - Arcane", coloredName = "|cff69ccf0Arcane|r", icon = 5143 },
            },
            [82] = {
                ["KrysioUI - Fire"] = { profileKey = "KrysioUI - Fire", coloredName = "|cff69ccf0Fire|r", icon = 133 },
            },
            [83] = {
                ["KrysioUI - Frost"] = { profileKey = "KrysioUI - Frost", coloredName = "|cff69ccf0Frost|r", icon = 49184 },
            },

            -- Warlock (classID = 9)
            [91] = {
                ["KrysioUI - Affliction"] = { profileKey = "KrysioUI - Affliction", coloredName = "|cff9482c9Affliction|r", icon = 980 },
            },
            [92] = {
                ["KrysioUI - Demonology"] = { profileKey = "KrysioUI - Demonology", coloredName = "|cff9482c9Demonology|r", icon = 697 },
            },
            [93] = {
                ["KrysioUI - Destruction"] = { profileKey = "KrysioUI - Destruction", coloredName = "|cff9482c9Destruction|r", icon = 59138 },
            },

            -- Monk (classID = 10)
            [101] = {
                ["KrysioUI - Brewmaster"] = { profileKey = "KrysioUI - Brewmaster", coloredName = "|cff00ff96Brewmaster|r", icon = 115070 },
            },
            [102] = {
                ["KrysioUI - Mistweaver"] = { profileKey = "KrysioUI - Mistweaver", coloredName = "|cff00ff96Mistweaver|r", icon = 115310 },
            },
            [103] = {
                ["KrysioUI - Windwalker"] = { profileKey = "KrysioUI - Windwalker", coloredName = "|cff00ff96Windwalker|r", icon = 108731 },
            },

            -- Druid (classID = 11)
            [111] = {
                ["KrysioUI - Balance"] = { profileKey = "KrysioUI - Balance", coloredName = "|cffff7d0aBalance|r", icon = 2912 },
            },
            [112] = {
                ["KrysioUI - Feral"] = { profileKey = "KrysioUI - Feral", coloredName = "|cffff7d0aFeral|r", icon = 16864 },
            },
            [113] = {
                ["KrysioUI - Guardian"] = { profileKey = "KrysioUI - Guardian", coloredName = "|cffff7d0aGuardian|r", icon = 20484 },
            },
            [114] = {
                ["KrysioUI - Restoration"] = { profileKey = "KrysioUI - Restoration", coloredName = "|cffff7d0aRestoration|r", icon = 8004 },
            },

            -- Demon Hunter (classID = 12)
            [121] = {
                ["KrysioUI - Havoc"] = { profileKey = "KrysioUI - Havoc", coloredName = "|cffa330c9Havoc|r", icon = 162794 },
            },
            [122] = {
                ["KrysioUI - Vengeance"] = { profileKey = "KrysioUI - Vengeance", coloredName = "|cffa330c9Vengeance|r", icon = 203720 },
            },
            [123] = {
                ["KrysioUI - Devourer"] = { profileKey = "KrysioUI - Devourer", coloredName = "|cffa330c9Devourer|r", icon = 162794 },
            },

            -- Evoker (classID = 13)
            [131] = {
                ["KrysioUI - Devastation"] = { profileKey = "KrysioUI - Devastation", coloredName = "|cff33937fDevastation|r", icon = 362874 },
            },
            [132] = {
                ["KrysioUI - Preservation"] = { profileKey = "KrysioUI - Preservation", coloredName = "|cff33937fPreservation|r", icon = 361469 },
            },
            [133] = {
                ["KrysioUI - Augmentation"] = { profileKey = "KrysioUI - Augmentation", coloredName = "|cff33937fAugmentation|r", icon = 396286 },
            },
        },

        profiles = {
            -- Warrior (classID = 1)
            [11] = {
                ["KrysioUI - Arms"] = "1|NZE/L0NhFMZbbBaDxH2ultuaDY0I8nYgqQERoqmv0BRJFZFUS3qbG7pILKK0ESXELBZCWp0RQkx8BlsXiTjPe2v53fMn97zPc47Tlqu02/nirNFt+ExPy/wawimopGFC5aCqUNdwhHnT4w2liBJRhlODKkEdQh1LYf0T6gjqAHejiFxCvUgtOwn1ivAywkmoN6h3GZ9JSKOyL4ibcB7wuyWh3cXcEGyyHfrmz/dMv9gAozPB4IJMSA+z5id8RB8RJAK4acj38UTwNC54jjDaJnaIAmeMEIvEkuA0ilsDkU6ostEDVYRTp8AYHxoSbHxQdC9hMd1lo0rUWPthlCGyTK8EjfMLr6030rLX1Ox6i5v/mgc6mgbddWiD2jRdugb1IlxvfndJ8WAgLwZFbqutd2gVtFJRzkPIOZy6GNEuPLa+pD0ztZJeTSRjE1a/NTY3Hf0D",
            },
            [12] = {
                ["KrysioUI - Fury"] = "1|NdDNSgJhFAZg06AWXUDvlGIbI8isHLPsn1NBRASBi+gCpEUERYsW2SCNZVgu2kSrZOjPrYsgFIJqFwTtI+oGWngDnXcmN8/3MXO+83fYapU7yoHcxTKkCDmFxGAHIeeQQdiTkGHYIcPX4uSVoWfyQl4hZ5AGxISUIEnYU5AEZBQyAomjVsFcDjKusdknyARkFh+7EI2aZrojzM+gfqnXg3XFulIyvUr8gbcI6j88U4pZYNSbkmg3fP79Lv6IkX7CEpk+5f2a3JAKuSV35J55vxkXRe2XKavkkynbWH2AZNjXMWFB5wSPXyxnkCDpVqy4UiWbY/zWSUBCTk/OfaIT+YvNHt2+vR4j/xN4fXNObxZv9lRzAWYhnHeXW3KX23A3mywHVpa293Y2ttKL4Wh4Ib269gc=",
            },
            [13] = {
                ["KrysioUI - Protection"] = "1|NZC/L8NRFMXb+gZVRQhxvvptv1VGk7CLSE6JVpt2tFgak4TJIqJFUz9HxkYHi6Um6S6xian+AY3ZImHwzmssn/fy3r3n3nMqzmE9WneOblbBKTAGJsAUOAwmwRGwB+x1A8FGAIyAHuiAAKfBIXAQ7EfzEwyDUXAUrW9wDG8f4CQ4Dk6geQ8OgH2gC866gVB83siVsgaL6wZbS/h9Mmc7ZrDwBc7ox1dNDh0XnR/T4z2oIiF4+skbvJaFilAVjoUT4VRKt6rb1O1ZghlBQxshg/ewpDSkHddbEK2UGXNwLlwIl8KVUBPOhGuDx5e7ZNlK2xbTGqrZhe2iXUvWXCn379WY6nS9G5N+VZEpwYiNz7M5mjSdulNc293f294ppv05fyOfLawsF9LZzB8=",
            },

            -- Paladin (classID = 2)
            [21] = {
                ["KrysioUI - Holy"] = "1|a2FpWCja9K1phq5kka9kkZ9kkb9kUaAUA2NiO4jokCyaJ1k0X7IoSLLoqWTRIpBYC4joBBFdIKIVRLRJFv2VLFoiWbRUsmi5ZNEyyXemkkUrJItWSr7bDJS/e0qyaJXku8mS7x9Kvg8BCqyfDCSyJksWhUi+KwYxZ4CI6SBiGoiYCiKmgEzuBRJrHwKJdR+AxM1myZKNUgxMJUlLFBuBTKZ2sDkwLYkT4MbMgJmQNU2hCey0vwxNCH81ffP3LqoszswP9VTQVfDw94kEAA==",
            },
            [22] = {
                ["KrysioUI - Protection"] = "1|bdC/SsNQFAbw2Lqpa+HLlNRRhfMIgijGiom13XVpURDBkrSxWmqs+GeodHOzt80zuAgufQ1XBUffwPNFSheX34FzL/d+5/Tmu6Zg8snzOiaLCGOELcgd5BpyY1tzCw1IAulB+pABpA25RLQEafFwmZQgTcgVpAuJIRHkAhLqyaFHtm0rV/QRtvH5CrlnKyA+vlzIA5o/kCc29smBcjIkhowgj6xjkpIX3toiO5i8se6Ssv6CumIXyZHirpIaGRJDRuSDkQJEK1rfTyEdrd+F1E20pY/mBrPc07jZv3+ZxrNBsgH9f8KnOtw0v3ObLSXO9qJr6li6277JV0vnceP4rOo5a05Q9iubGxXP3/sF",
            },
            [23] = {
                ["KrysioUI - Retribution"] = "1|a2FpWCje2DTDWoqB0SsQSPjXSm65J+m9V9L7sqT3JUnvg5LeRyW9T0h675f0PiDpfVbS+7xkeISk92PJsKeS3hclwx5JhpdJhkdKel+RDC+X9L4gGR4ONGbjWSCRtRpIbBADEqtmSDEwuZQCWT6NQNa9ZpCS0yDilKT3TiDNfRhI8JgCCT4zydN1IIWrQPpAwmuYgcS6fhBhBSSqgG7YIem9G2TBMhCxEkSsABHLQGRSkKWOIH0TgcT6FJAt50CWeoCI/UDuakmQ0e8WKzaCOUz9EDdsPA01dSnMLLCDwE7beArmbIhNy6CObIQ5gM9MoR0cMHvBAXMJHH6PgWHZGOZdVFmcmR/qqaCrEOQaEuTpFBri6e8HAA==",
            },

            -- Hunter (classID = 3)
            [31] = {
                ["KrysioUI - BeastMastery"] = "1|VdA7S8NgFAbg2Dr4E/oWjsYh0EUQd1GLKRStl9p6mbwudRHMksSorQgqKl0UnJRK/QNdXBR/iNfBWWs7C543JYPL80G+nPec7xx2l2uJvlr84GoY3i28+6QRG3xU0jfwTTxdQ6YhBcgMZAotFzIPWUD7C+3vpNE1LggcPU9GIXkEDUgOUkS7CZlFrwGZhNWE1dJf7F9YP3pulhV3hayRdfKpHD+TF/JG3skHw0eU0wfl7FI574F/xyBXyaTg15mwTFbJBu8CfUJ2SLmwOWaV33yyR7bJPi9KbPJa769oZqwajhkFdYrcqDKTisrDok6bnX9p7Kpp4TjmETcSrqOzn8DhEoOGUdGt1uKLiYltzyltFbPmgJm2x+YKZk6x80t/",
            },
            [32] = {
                ["KrysioUI - Marksmanship"] = "1|a2FpWCih0PStaYaTJMcmSY7Nkpzikj1akhx3JLnYJXlrJLk4JHn7JTkXS/IelJTdJ5lxRPLzCcnPJyU5F0oxMLpsluTNkdxfI8m5SJJLXJK3VoqB6Zaz5OdTklycknwMknwBknwikj2pknw2QNWuNUAiqw1IVEwGcatB3HYQdyqISAcSP5xArFQQMQWkpBakpAlENIOIFhDRCCJaQbZvAxFbQdwOING5AqRtGoiYDiJmgIinIImlIGIZiFgOIlaCiFVAoqsQSHT3AIkebSDRC3QLk8Z9kLY0IGv/y8XMYLvamSbAXZUOsxfiKrCDOoD+hLkd4pxGuItbYQ4DewXsUddqhTZ4gAHDDxJm+2uavoV7F1UWZ+aHeiroKvg6BnkH+zr6BXt4BgAA",
            },
            [33] = {
                ["KrysioUI - Survival"] = "1|PdBNSwJRFAbgyfoN0SscnBZtEn9BUGppDrlKRihoU7SwgYKCMAjKPjbqWEELt0G7PiDaleVHtKt+QLs25bIU2rTpvFO6ee69w5n33Hv2+rZPBgZzO2XLb/jCm5AZyKzf6Fkuk3XIHALXul3KQyKQOCQKSUDCqD6iZUM+IaMQC04NTh1tG60QnAacD/0pNgyZgExCxtDegozrt2wFgRbXplJ8Ic/kCUMjusYvyRs7FohLjlh/Q27JHamROmmQdyV/Rs7JBblSCt8MX1Rc74X3LK7qbqFfmU8orw/KcZFHF4EvrkV2LRFvd0AO+aAQc3nFWFDrfjKnxq43Hx2dF+dzO/XZyn+ppnaDSt2gYCct2/ybB1+qjc19DrY7NYn25vROudTU6sZaZsW2zJCZsqfTVjqS/AU=",
            },

            -- Rogue (classID = 4)
            [41] = {
                ["KrysioUI - Assassination"] = "1|TZFNS0JREIbV7B8UOLbRoEWZ0KYMgkprI4Et7GtZLQS1CBLinAjKm1IGQXBBLIPMjxLaZZ+4yHVl9UNyl64KmvdkFFyemXOYM3fmfWPmrVNLt9bQUjMkNkhsWg3GpJnqAySCJNZIREgkcdcCtFJilkSaxB7pdhL7JA5I9pPQqf5Bso92Orlq4ROlNZJDJAeRvpPQSMRJOnBaZASeSI5znF9iFG9oPYDLZ5I+juky47iNEXYha0fNPSNboUSKEkjDTkaoZDWYql04jgJuYIxx1IPMA4yg8SO64r8XWcoPI+aAPFAAzoBzRgYjhq4Yh19AFXgBXoE3TPFAYpljzoq5SgDqi9fALXCHqhqyGBAHLvGig3GCvhkMmOktGKNKKpOuZFCTK2H+b+VRev0Kka00F29qp8Rw/Qinlv1TQUmYLhu22UF2Uxlr22UjlAtwD9axgQ5YJzR7lMXRGnOWiVUZCa5Me21Om9vv58/rc095J33f",
            },
            [42] = {
                ["KrysioUI - Outlaw"] = "1|VZC7S4JRGMa9NNQ/UD0uubQEnqWxq6NUWKK2FChBEA5FN9NBM5qc+g4NQQ19fmqpU0QJ3SDagwah7DYFLc0NLr2PUtDyO+95zwvneX/bbZtmd5/p3NqbhJqACqHkw7EFFYQKw/hCwYPSgctmPxuEcQfjAdoLfQKjAd0B3Y+9hfwnjHdoP3SMg8PQs9BdUp6bUOPQFstD6F7oBDw1ucV2oSJyzs/A6kTuCbkou2moKMoDUt5WBJEPVJwofvMpJbgKCqp1qAA7CZfNcd/Dap1YIzaIOLHKJCPEqGBpjpVXcMGHWFJQeiZeiFfijSNDSJ7ypxAz5IkicUQUUNmX87KdA2F2SkRZcPMoYbLXeVtGlDl2mtl/AzejtDI246W4pAq09qrW/7LH/y+VFhHuLI2JW09NbLcsUqiItOjbaNgzTeOmc2psObGysBjyuT1ufyg47p3+AQ==",
            },
            [43] = {
                ["KrysioUI - Subtlety"] = "1|a2FpWCih3dg0w1KKgTHhmWSvjGTnB8mlsyR7n0v2ekpe/i5ZLSpZLSPZ/leKgYmvSLJaULIjQLJaTLJaXLJaRLITyBCWrJaSnHRdsuqqZLWk5NLXkstsJKulJatlJaslgJpEPwGJLxslq+UkJ2RJLuuU7IuQnHAbaFvWQRBxCKREF0gIM4C4ZyT7tIEccW/J/tuSEyZIrjEHiR4FEcdAxFmgJD8bkBDbDlJ2H0hIFAOJMzNAssdBxAkQcRJEnAIRp5cwNAE9AfYeUz9I5ADMXnFvuHqw0jNgt4DthDrnIIg1E2402NTTYOsUOmBhIQILDngoMTYCA6Mx2LuosjgzP9RTQVchONQpxMc1JBIA",
            },

            -- Priest (classID = 5)
            [51] = {
                ["KrysioUI - Discipline"] = "1|a2FpWChhvJC5aYaFJE+VJMd2SY4dktxAcrckxy5JITVJjp2SHFskObZJMTDZmQMJrxeSQm2SPO6S/M8k+Z9L8ghL8r+Q5Ngqyf9SioFR1xBI6DRKcuVL3jEBMVtARCuI6AARXSCiG0T0gIheENEHIvpBxESQCeogQhNEaIEIbRChCyL0QIQ+iDAAEvnTgUSBBNBBCp+AhMVZIGEpACRsN4GIzSBiC5BwZJIU4JIU0ACZ3wYi2oGC//YvZWyCuJRjJ1M/3KFtUIeCDYE4BeQ8oHFQE7rh3mmHegJsC6OuBtAWxUawQxRaEAF0V4mhCRxwwBBayBzqXVRZnJkf6qmgq+DiGezsGeDj6ecKAA==",
            },
            [52] = {
                ["KrysioUI - Holy"] = "1|a2FpWChh0vStaYaNJJeWJAe3JJeGJAevJAePpMFeSQ4uSQ4OSQ5WSV4zKQYmu02SHGySBvukGBhXzgfyvVUkea0keW1B/AWSvHaSvJaSHJySXNqSvOaSfEslea0l+ZYAJVWMgIR6G4hQAhEhQEJVCyRxDMT6CiQ05IBE8m1JofOSIqcki50kxRkkxe2BYmrqICV9IMU/QNxIEPEBZMoOkDZZEBEAIgJBBMiOdhYQ8RrkqIUgYhGIWAwiQG5ZXQok1piCiMNAYt3BJYxNEEcz9QPthbkR6h6YG9FcAfaL6leICyG+g/tJLVKhGRgm4OCwYmgEB1vTN3/vosrizPxQTwVdBQ9/n0gA",
            },
            [53] = {
                ["KrysioUI - Shadow"] = "1|PdG7SgNBGAXgzRK8JBKw8wQGf1DBInbeAi4hIJqLZs3NtAqm0CIBbRQUjERXEBsttFC8gIldihRa+AB5CEsfwMZa52Q3Nh//7rAzc87W/cdPIzO1k1sbYkL8kCCkD6O/kCGID4/RsOFzJjTNOqQfahZqGmoeagH7gAxwuYCNa8ggVBRqDpGCfnd/SI4wFoCyICFukCF22DBjBrYu+WEakyWU4xxziHSw+aZXrYp+fglwqnIlq9kpc1ojq3ohFeRkE27q3JAlskxWSIokSJLkSZGsk3fNwx0PapJPTWOYcJdGi3zxuiCn5Iw45Jx8kG/N67imxZraPsLD27xk4ufZvOrm7qb1Lp35D5Lr5fKyuuljhltMpOOF9XJme+VZFblwu9Vdu717jbNsCXX/gqV/Ti2b3j3Y264WkzIl+UR80S79AQ==",
            },

            -- Death Knight (classID = 6)
            [61] = {
                ["KrysioUI - Blood"] = "1|RdA7SIJRGAZgU6fM2g69NhzjtFVrm0u1dAEjiPpHhywnIamwqUIKikbpsv3QH7Q1NbWIUxJ2c2vVoV8tu1NT32tIywPn4+PjPW/Gv253R2zf5sE4LD8sHwoOVAP6FsqFqsNEoJ5x2YB6DHm8Ixb0DUwXTCdMELoIXYK+g76GCUDVoO+Rz8J0oNyPPhXytCXWhJhLqqRG6uSJvJB38kG+yI9QfhUq24K7R/iMfUqC9iseXYU5gcnBRPlalnnglPGKyE9zk+uJFZKWcTDJ2ZtQ3SGzMI6MH0rC/AX5FuJDJEXOiIT0LsSFxR4yRyxh/1w4rAhHA8e9mdbVv/s87d1thZU8JtfM24wi4f4Tt0LKT8JbLFsqZ9kNtl5wPBvNum3f1MRSOpVIzoyFB8PDk9Ho6C8=",
            },
            [62] = {
                ["KrysioUI - Frost"] = "1|TZC7SgNREIbXJSqaBzB/sFix1saAVjaKIBESN+YVhGWOBJLCSyUbUcFGwegqmLhY5Cm8FGLyBHa2Id7AG0s0Cs6cJSIcvjnM9Z/ZiKz7sUk3cL1pUBOqB6oX9AxqYWkc9A66Bz2AnkCPoG/QD5gN+kRjCvSF+gToBfSKHL830Efc6HIqglNGaQ43bbbpDFQEyuDvfB/jIMFINSUyKr5lKShDdYtnhWH3MzZ3BeeM/WvGYVKwJrhleJLsJaBMtkcyzR6TNicCX2JXjONFwR2jnBcU4oY5PCDRPRlsi5gLaTmIWiDToyK7ylmNLKN4ydiKnQ1td7I5MZQZDQt0tW5Wqpo7fwIq4bZakl5Z30Pf4d9dHN8qds7ccoN0Mr9acHLZWWvEmrFTmYVf",
            },
            [63] = {
                ["KrysioUI - Unholy"] = "1|NZHfK4NxFMa310LNTJrZs9Lm0oUb/4A7bX5GLaZFu1pjZ29ZkQtlfuyCZGykkORfkAvcLDf+BhfupkhJrkQ4z3dz83lP5zzveZ/nPRuu1fNAf37taATSCQlArKDDmfJDJnF/i8wPxKENX4pIQ9zIfEMaYV/CtiFtEC+kBdKq87kXSBOyr5BmiAfSAHFpey+BalGfE1fcMU9kqP5iJYqyU1G6VoQGIH5Kn9nJUVAiytS/URrhwuOgw+pZZPWg2AcxxemB4uROcfrLaRcHTwpPBdIBaddyt6ooPnLhO1fzlfQNq6wi+cnqUPcXtvjymVbrK4rokiLuIgYV0wlFok8x41XM+gn2kmrQ2vy46N4x367FMQHppiakxuSthTCZTNjQQH2N/gBr27hT33UfxlbNoHFuTHsq/1Z9Wc0XLpjb2DwP7+TWg+THhxaWc2k7Fg33hmOjkbHh+B8=",
            },

            -- Shaman (classID = 7)
            [71] = {
                ["KrysioUI - Elemental"] = "1|VdHLSkJRFAZgNbtqjbr4C4GDQAjsxtroqQiETip5aWA0UJoUlKPKmjRLs+iCFtWgadC0V+gChwb1DPUYTrru/5iDJt9hr7P3Xot/V9x7N75YuV6+zklXIHVINGQG6sTvcFotxA2Zg8SgziD7kAQkBXUEdQVVhapBnUKdQ11AXUIOIEmoY4gJqUDS+oLwJ3JvyL1DDMgkZApyCFmARCBxSMbvcA1/6H0Rdgt/YaXA7zf5YdlJXKSNtJNOzfoDeSRPrHWRbtJL+kg/GSA+skm2SJG8aIwhMkJGyRgZJxOanSXu8xAvayHkV7l4Rd6D5UGWgly3kg7Sw3nuefSO4XFkiyNb/GtxbouDWrzT4p3Pa7fOks7LVfs72UjDCNlpNHNpdPD8793o6G22NYKBqv0CmWbCSTtwg/nr2PkEcTv2iqOkX7hcz84Xd7cLG4uJQChgJs2Umc5Gk78=",
            },
            [72] = {
                ["KrysioUI - Enhancement"] = "1|NdE7SEJRHAZwy4iGCAqEviabmjJMCFK8eQ3BKG9F6l4UJBH2GMqth0FLe6tDS0MQ9LSXPSx62ZBWQ4S9a4uWhpb+3zWX33ndc8//nC9aNBGr9MaMU/N9sPTDEoZlBMogLMOwRmBLot4Eezkaf6DOwO6tMhSoXXC0wTUG5RuuVSh1cH7DuQpHLRxlXPeRNqhZtu2kg3TC7YD1Hp8VcI7D3oumFU5rULQqQ+HiFwfbZIfskQQ5IklyIoT8JECCgnuDC6eo0diekXOSJhlyI8RT7N2SO3JP9PIeyRN5Jq/kjbyTD+694jGbhDW5D8gh0QvbZ29diJayF+fcCxqGpF2PcUa/wwNsAxzoV+Nm9VjYbRb21oTEr3DdLaRLyLKQqRC2euRtQtOCb05YKubeLXLB4aWQTCwYJiWywrn8f90JGE3/3+SqyG15yBecK+ElX5SUa5zUDzPPMiQ1K9kwIclJ0lI0ia06qr+F/tC5sOKpmDHYOhIZDYUDLeZas0fzqlqzx+fR/H8=",
            },
            [73] = {
                ["KrysioUI - Restoration"] = "1|JdDJS0JRFAZwE7eB2oCfTS+ikTRtohFpYSFBgmkDtGlauAqMs2h135OCaKIR2sVr26JVogXSunb9J1Eptep+uvmdwzmHew9n32Xavpjtyt6uwSzDLEHckADEA/FC6iF1kAZII8QH88PvqHm1NcU7SBOkGdIC6YZ6gPRCuiBtkB5IK8SA+oZ0Qjog7VA/UCWoMtQv1J9+IFiA+CGAdQBrHdY7zG1Yb5BlNoNkgAySIU16k9kwGdEUXpiNkjEyzpENZhNkikyTvCZ0RI7JCTklZ+ScXJBLckWuyY0mHCWzZA6ftTpmPGQLsqLjU1GTcxOWc17ypcn3c8EQCWueJyGryKb8DudjH1cKEHaCkXvnYfUClTrPUD1ApDKi/zGy1TvZrqX5zN5ueicVMwJGIrqYjCdmkrH4wj8=",
            },

            -- Mage (classID = 8)
            [81] = {
                ["KrysioUI - Arcane"] = "1|PdA7SwNBFAXgNST4B+TiWZHsH4iFT7KR4BosRAhEsVIsjI02YoKF7wchyvoHJN1ia6UBMSm0srDZ1DZqQNTWykQQz52AzcfMHRjOuaXoYdCbC2LH5x78FvCDcA1owy4Br8ALwifIMCQFSUIGIWOQDBoWZBwyCr+NszhkCOJCJiEjaJ5C0pAJNJdsqyv/ZVuR4jfsFTSy6Nvg6DkKOw/7gcdqgiRrxO0hqbhe6/qwqLMKSXeT8p1yT65uyPW2sqPsKnvKvnKgXOoHA8oCuX1XPpRP8vjGQIVfTVVXWmSzn1Tn+LocXlhHrBzxTYhOYJPNxHIrbPEftGaqmRrOiW6C7bmSzibMVoJYbqawVVxdn592Eo43m/GyU38=",
            },
            [82] = {
                ["KrysioUI - Fire"] = "1|NdA9S8NQFAbg2Do5+HXE5E2XuLj1F0gFoynGUEoDTm5Obf0ItoNx8wsF8wfEyYj/oKIOoig46NTFzUVxEvQ3eN60Ls/lcLnn3PccDu6mVpjm9089mOdImkjWbSPnTkN8iAupQRaQrEECmBfovsB8g3ioFyDzkCV0XyFzkDJkERKibkMqkCo+321jYKajzH7A8vQsnSkPX0gaQAWWq1VzSzm6J4/kiTwrd8NkhIySMTKurGa3E2SSmMQiIDYpwBpi84g/uCXXGmnlW9n+YXlDrrRs6cBcu8SLItkgm+RXiVnGLOPo0jhgbM0vQe6k/z5r3BvRG9b5766Zs5jZSOeYO9R9ZtvVrfYXXJva05+m+WrQ2mk3omXfKTplP/T+AA==",
            },
            [83] = {
                ["KrysioUI - Frost"] = "1|PdA9S8NQGAXgGLI45d7SwVMUsjkJoiJI8GMqiEOL1R8gCsFFwaIgilYRHTILTkIVHNTBWeNnW8Uxf0AUCxbTVgV/gO9pqctzL4T3nNx3x8rlOzJ5a/sgCf8dYSfUV8Iwh/ah+6CqiB1B1eGXYa/B3oQ3Ansddg7qB/YvvFGoGnQ/tIV4O3QKKoL6RtgFbxh6EHoAOo3YbcJoW+iFNytn6UzYLZCiEFySKxKQa3JD7sg9eSCcCGTCXH7lrUQeyZNQ6GbyufDyLBQvhLFTUmZRKLhV8kE+OcZ/ciNSkdCVOcGNCzOSbGY3WHRI3vj1hNSOjS15uOm3XtFMi1pdjdZmV6VVw9ZGuBQ6e7Lc5lL/V8yF1/NWemJpNTu/OD3u9DjJyVRm6g8=",
            },

            -- Warlock (classID = 9)
            [91] = {
                ["KrysioUI - Affliction"] = "1|a2FpWCgR3fStaYalFANj2l8Q8U+yI1dS7brk9xZJtZuSajckPb0l1U5Jqp2RVDsnqXZW8nuKZEeOFAPTlL+Salcl1c5Lql2RVLssqXYRKMY1CURMllS7IPk9VfJ7suT3NEm1e5JqD4EGZzGCCCYg8UYJRLgDCfdVQOJdBYiYI6n2FEh//Sep9gBIe0iACDsg8T0GRLSBiA0g0yeCiCkgLQeArAVtIKIdRHSAiE4Q0QUknp8CGSAOZBUmA1lfTIGsfcuArJeFSxhbIM4EuTEN7GymdpidX//BVIP1gUyAON3DTqEd6HNIEED9fwYcMucUG8HOafoW6l1UWZyZH+qpoKvg6Obm4+kc4unvBwA=",
            },
            [92] = {
                ["KrysioUI - Demonology"] = "1|a2FpWCgRs5C5aYa9JK+SFAOTW5Mk03xJrm1ApuBWSe6nkt9dJL+7Sn53BArwT5DsWCfJzCfJcU6SU0+SkwkoNtVYsmO9JPtuye/OklyMkpxJkpwXJTkvAGUEsiS/O4F07ZNUiJViYPRkAJm5TZLphyQzp6SYqKTYWUmVS5KqQGFGj2sg4gqQyLIBac0GEnr7QKwckKYkEJEMIlIkOWdLMv0GyWRKclYC6QWHQMRhEHEERBwFEcdAxD8Q8R9IHE4ESEBDnk8E2XMdZI8tkLuQEUSA3DUtciljE9hUsMuZuqGyEEd5XAO6GuwVsBdgZoB8BDUIZIZwumIT0Hlgpyt0gMKkYx0khDiZQOEFCbiO9QyN4MBdyBzqXVRZnJkf6qmgq+Di6uvv5+/j7x4JAA==",
            },
            [93] = {
                ["KrysioUI - Destruction"] = "1|TZA9L0NRGMdvm0bD3KH/Dk0lVvENvATDn4SgtYmXQbhBtaU0XtreFh0MhpYSHZqIQXwTg0hY+AJ2cWuhnue0Esvv3HPOc577/H9FX64enMs71bGQ5XU+wXswDq6Ah2AOPAD34DTAfZRe4BbABJgEN8BNuHchy+M9kpdlP76CKD2DGTAF7oI74LbcdM0rFuA+oREGt2RXKysqYBE8Bk+kSXNK0RT8fAi+bwV2P7gO2lhOS33no/bp068muKbrkBYNCJgFHV1zcux7EHQkFHWBv0ffLSqWBNd6VgsooopzxYWiqrhUXCleFW8CyxK8B7R9QaE/sgdvuvPmzntmxjIztsbWKhOxFcrMVKv8JTMZtYcJJI1M0HYqO3JqnKrOluG27bTKF7tuwQgX157iP7civRHOz44nM6nVeIyR3sjI6Ex0OjYc5eTELw==",
            },

            -- Monk (classID = 10)
            [101] = {
                ["KrysioUI - Brewmaster"] = "1|PZC9SgNREIXXJZK8gZ5AyAaFOyoi+AYKKTTYRIONYBPBiBpRuGAnq1hYiY22wdbGwpfwH9QkKv5xrUXQ7BqzGGcWTfMNc2eYe87ZiKyVOmdcz90bhV6AnodehN6BLoIsUANmEEe7UF9QPkwUyoOqQ32DbKgfqGbcaku+QQVQNZgYTBmmAjMFU4XZhGqgJwHyQLW4ZXf5vD19LrgF8Y0oKMadk5KnZ95w8qBP9L6jbwDkgwK8Rng2u82zUoaxdCqrJ4IzwYXgUnAFqku9FtwIqoI7wT3oQ+qD4FHwJHgRGL6aKAjmGMljUdEhOBTFB6B2rt3l/dQ6H+GOv7G3/n20hLF8ttnyyPb80E4o2eEggr+gmmFskp/r5TLLqyuFYm7E6XeGs+nJsaHxiXT2Fw==",
            },
            [102] = {
                ["KrysioUI - Mistweaver"] = "1|a2FpWCiRtpClaYaJpF6PFANj4hYQsRFEbJXU65fUmwpirgcRm0HEJkm9CSB6g6T+Skn9dEn9Y5IGfpJ6kyUNAiT1JkoekpDU65PU65XUmyapd1dS756k3n1J/UZJ/eOSBv6S+leBWjPmAYnN1yQNs4D0hmeSB0H8g9eAxOEAIHHAVfLgbZCyBZIfrgDpTY6SH9YB6XsdUgxM/hdAMouAxDmQk7YyA8Xy2kDEayDxchKQeNsFJN7sWsrYBHZGH1M3RD/InCswI8C6MxaADQM6BGLjAVewgxiaESEADhCFFpBfgb4E+lU/XbERbPFCllDvosrizPxQTwVdBV/P4JBwV8cw1yAA",
            },
            [103] = {
                ["KrysioUI - Windwalker"] = "1|a2FpWCiR3tg0w1SybLJk2VTJsmmSZbOkGBjF1CTLZkiWzZEsmy1ZziRZ9k2y7I9k2XfJsh+SZf8ky/5Klv2SLGeULFcHqk1cDSLWgIh1IGKt5KECKQam1x8ky34D6bdhQMHrpZLlakD67g8gcfMtkBB9CBLeJXmoF0gnBQCJG8tBhDOIcAMS98D67oK4LpLlmkA6A2T89RIQC2gbU8EfkNwpkFKQM264AgmhmUCJIm8g8Qrog59A+k3oYsVmZGmgaqZOmEFAB4DdBbYH7KQbLlDzwdYBLVHoAHsC4pnXH8A+hPsV7OvVQA83hnoXVRZn5od6KugqhHv6uYQ7+ni7BgEA",
            },

            -- Druid (classID = 11)
            [111] = {
                ["KrysioUI - Balance"] = "1|NZC/L4NhEMd7L4tBN3LXlLyTSfkHkPR9Y3hpOjTehlXbN5FoX4rBJm8s0hSDQWxlalilibVd/Eq6Kk3aMBipKDF5vi9dPve9ey53z/d2+3dK7Hpd73ghFKCloMLiD19wXV4rfIZSiat8wkmhPiFWhdVzoQMVH68UWgWhTZmbESoK7QtVhWr8zm319FTmjlSOhDROcVqozDExHaEIhtaAsMLyC9Qw1DPUGDAu2iDikEI2CbjAGrCOL1wrNFpIp5DeAffALXCDBxsDRqCmoUYBf/UEMAmf32IOoCEvZgH5B/ApxqEYl6GAlngTzeYtFLtoy0F9KTQtjosWFDJVV73BGXaU8CrIHk71PXhNcebffIfT7HBbK/Y8ZnMc47g/2LfbtHzPvT3+ir+zhP3beN3EfH57Y8W1LT2iG9FYNG7O/gI=",
            },
            [112] = {
                ["KrysioUI - Feral"] = "1|RZA7LENhHMXb2+9eSQ0WKcd0q16JWEyWDpJW0jBIk0rZxCCoeC3aiCCSokKJ1yS5KhKJsHgsHqNJRCQGukglaA1Wg8T/lMbyu+fL/9zz/74zq6as8mHLMbPVVWGzu9aIVUH4DuoeepHITBN0L/R66OB0RTDopFoXdO8h+wI1DjUPNYdJDWoBKiWTiBtqFyohcuAQagIqKjLdibMMlAUVl9NTv+C5EdsjUDEYTuifMLz82QM9AWMDxqaceu0MeaUqpTqgo4aoIqo5sHFwJHhMUr0RWSJHyzXVO1Udb35BnBOXxJWgJ03LB/wl8IVorIWvQ75llUSYWCKWiST0B9awQ6Sgy3u1YIBRXOnKrzSpuDL9xT4zYrm9EZzYCbmudrwvOC3mUfK1+HfKPS3B2uKfX9KkkEJCxFMIdOUKzUhifrlsM+P5YmP/hf4WLF1bjvbW0ehY31AoYDaYLf5gc9sP",
            },
            [113] = {
                ["KrysioUI - Guardian"] = "1|PdA9LENRFAfw9uUlTl+7NDH03xiehOpiNLBIE9E0EoMqFSpvbQ1CB7EIxeJrtoh0ECY2oxiYTKyGfuoXGzaD839Ry+++c3Lf/9x798ztYmitaBZOE2GP18kh/Yj0g376DEgL1iEORsIeY/JJW8YPrCPuWtFOqEXapAN7HFKFVOALQsqwhiAliAmpQ2rYGIB0dGNyFNYYpIGtHORdg3papE06hD0JcsIyAg7XWQTOuGbIPPxsZu9ZzJFFsqS8hnmQMqmQKqmROnmjTaIjjL5LcsWypETPlXgvoxYYf6flTR7+uK4R/vnyqTwPkohye83eF/mG1bzwFpj0AevYOPn7xQ1xD6rBbpJeSQtEu0nM9Dop91rdyU5GL+jZ7T63k2Nuw97nq/6/sJT7d3Rq0UxOrW/ms6uphD1sx1OxmYlEbPoX",
            },
            [114] = {
                ["KrysioUI - Restoration"] = "1|VdG9L0NRGAbw3tKExK5PGXrurUQiFqQkiDaNUuU2qmrVRCVikNRkq6qPGk3WRjr5AxhMDEgkPqtBgmIu9Q/U+7SRsPxOznvuOe9zzk3XJ7P2RNaW2jVhbENPOixa7AR6M/R+6A7ogG5n7YzckFPySArkgdySF3JP3kmevJFXqKCMxQ2oQSgvlMnqBblyWKyTLVBDnDxD+aFGoCagRqECMK5RKaGyJx917ZA8aSIhGAMyjmtCnw/tlzCKMEyUj6TQ64aLneejPPaDnDPApqz1HAvufSGTQ9si+8/BmGUxLnS3CqU6odCAAz+3PkF5OG/kypjw6SLc+pUWyjNEuli/O8ihTlvl7e0Etdmfdqqb6Pd8dr6Xv81WbSWjJq1K1OJmcc/3fg3kkh2W1+mOytmgwsbK8sDQdcHYI6w8NTkVDYGwmEzB8=",
            },

            -- Demon Hunter (classID = 12)
            [121] = {
                ["KrysioUI - Havoc"] = "1|a2FpWChR2dg0w1Jy3l7Jefsk1wlJrguXnHdWcn6m5PwsyXnzJecvl5yfIzn3j+T8Lsl5DJLzqyXn/pecxyw5j0lyHovk3H9SDIy//EDEQsl55yTn6UnO3ym54AZQILEKSPzUARLpCSAiEUh8Ow+SqAQRJZILRSUX3AQy/zFLMTB93QRk/UgByTRLzt8BpN9kAYn3mkDiSziIOAzS7wkiekAGrwARv4E6dxwCEtM6QMR2IDFDG0SAuDOeAomZBUBipy6Q+CYPJH5tWMrYCPQKUzfMhSAnQWwHuzWxEsVdEGcnloB9odgINkuhBRxYLCDPzjvH0AQKsXVCjQHeRZXFmfmhngq6Ch6OYf7OAA==",
            },
            [122] = {
                ["KrysioUI - Vengeance"] = "1|NZA/S8NgEMbTJBLFRZ18OsXF6YKDe0EkSFsoDdjWP2ipgphBRB2KnTSGdKiKbi4KxaJ+Aj+Aq47VjyFOgqDoc1GX393D3fvecxfbB93xVteKLnIIEgQ9yA2khuAakkBWIOuQOoIQwSa8AiSGrGaNzCfrR5BFyBqkAlmALEOqkKWsYZ70IZE2lSmsScLcIIy8ygfIHWPmA9JA8wmeA28Q3hCabT75brFmv0FuKRp1isKOIqeyxmzgUPFKOPfw+oxnL8T5iGJUMUYcf6mNaeJ0WLNQ8Ux03onHSwRFxvJVz4h0W0nMzv88ZyudRwe/Ru2p1G3anpqg79SWm+hZ9CZ/O/NCEk9EdMXvu9Z8cXd/L9yu5F3PrfqlOX+mNOv/AA==",
            },
            [123] = {
                ["KrysioUI - Devourer"] = "1|a2FpWChR3fStaYax5EEGKQbGhE4QkQ8iykFEB4holzzICKSVFkkeZAbxi0BEIYgoBhElIKIURBRIMTC53AEpnQXi5gKJPgEQwQfi5oGIhSBuLJBIfgki3gKJ3j1AbZNWgYjVIO5ekMQrEPEaRLwBEe9AErtAxG4QsQ9E3AARN0HEZ5ChvCCCH0Q4g4gKEFEJJKbKgggwNw5ox+SpIMIUZNsaELF2MUMT3M+dTJ1QB4GdAXEQ2PVgf4CcC3YpxAsJCxWaoN4GhlTTt2DvosrizPxQTwVdBRfXMP/QINcgAA==",
            },

            -- Evoker (classID = 13)
            [131] = {
                ["KrysioUI - Devastation"] = "1|NZC9L4NRFMb78eZI7MTTqemsEwPx0RQdSkJEddRNYyIM0s1X3m7SImJtSFq1GAxEJRL0y1vBH9C8weA/sDrPpcvv3pN78jv3PHvWVqFvt+DfOYnBvoRUIHeQG8g97AzkOuDxro4QY4pmEfYEi15IA9KE1FkNo30FeUF7PuDxRfJwnyCvkGeIA3ljxyi6uiE1tH9YDSlaFtwzKsvY39TTScGdhDzqNdVDLCvSF2zPEwfEoaJKYY1fqt8qGhFKBohBokScU9hPvEMe4IbgeiFVto8rPj75FKYxp1ia5qgiyyPeyrrFV1bxfcySxnrl1LttVvXlOs0ty1g4wKiNS9dxQ5056ZLuqKM7M5zUv159waxG+ReQSaphYjVZFfzJmfXMxsrqYjwYDk7FktGFRDQRn5v9BQ==",
            },
            [132] = {
                ["KrysioUI - Preservation"] = "1|a2FpWCjRspCtaYaNJHOKJHOqJHOGJHOaJHOCJHOiFAOT/X9JDlNJDhNJ5kLJ68slmRdKMsdLXrsneW22JIuYJLOOFANjTBFQnYOVJHO2JHOOJHMXUIhRRJI5V5I5T5K5QJK5SJK5WJJdQ5I5S/LtFsm3myWZf0uyZEqy+AAVCn4CEglJQCI2GkToSP62BNJR/4BE9HaQ4SIgwhkk9xxI5K0BEVdBxDUQcR1I5AeCiBCgI54cBhKO9kBuRpykwHwQHQsigEYz7c2WvK4IpPfsXcLYCHYiUytUDqoKpAXoMIUmoEKgZxiagD4Eh8BCtnDvosrizPxQTwVdhYAg12DXoDDHEE9/PwA=",
            },
            [133] = {
                ["KrysioUI - Augmentation"] = "1|Nc+7SgNREAbgNcj/CvoHhLWzCWiZQnQRkSDGwg2WJoJiqoiCGmx08fIK8U7wAXwCOy3EKoLxuokxGxMVtZGtnTmY5pthdmbPzFbnRrF72wu9wjBxR5SJN6JJNIgWcU+8E5+ETzxFrcjQRdTqyMiHGlEnAuKV+CEetdykP0M8ExWiKs3uunLGSj/xQP9KemZDYWFVSGeF3B7xrXFfOVKOlRNtiGt2rfzqUF5rc8SXxnktF4TFLmVKHnI+tGtNsvOi8NIjNCyhVVZuhcOYtqxIVhsQ6n1KSbkRghGdGBQOLk97N02M7JoJOeH/5+09zBKyjL1jzg3ap1fNg144Pb6UX87mUgk7ZjupsYnRpOu4icnkHw==",
            },
        },
    },
})
