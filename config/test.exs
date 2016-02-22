use Mix.Config

config :guardian, Guardian,
      issuer: "GuardianRefresh",
      secret_key: "auisdhfuisdfnerutwitrufdsgjbkladjf",
      serializer: GuardianRefresh.TestGuardianSerializer
