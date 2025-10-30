"""An interactive Weightloss Tracking Game"""

from byllm.lib import Model;

# Initialize global AI model
global llm = Model(model_name="gemini-2.5-flash", verbose=false);

# LLM-driven weight evaluation function
def give_proper_weight(weight: float, height: float) -> str by llm() {
    """AI evaluates if user's weight is healthy for their height."""
    return f"""
    Analyze the user's body weight and height below:
    - Weight: {weight} kg
    - Height: {height} meters
    
    Calculate their BMI and classify it (Underweight, Normal, Overweight, Obese).
    Provide short advice on how to improve their fitness in one friendly sentence.
    Format the output like this:
    [BMI] - [Category] | Advice: [one sentence]
    """;
};

architype turn {
    has proper_weight: str;

    def on_spawn(weight: float, height: float) {
        std.out("🤖 Calculating your ideal body metrics...");
        proper_weight = give_proper_weight(weight, height);
        std.out("📤 Your AI health report: " + proper_weight);
    };
};

walker weightloss {
    # walker attributes
    has attempts: int = 1;

    # walker abilities
    can start with root entry;
    can process_weight_and_height with turn entry;

    # Define start and loop functions
    def start {
        std.out("🏁 Welcome to the Weightloss Game!");
        std.out("Track your healthy weight with the help of AI 😎");

        loop {
            std.out("\\n🔢 Enter your weight in kilograms:");
            weight = std.input();

            std.out("📏 Enter your height in meters:");
            height = std.input();

            try {
                w = float(weight);
                h = float(height);
                spawn here ++ turn(weight=w, height=h);
            } catch {
                std.out("⚠️ Please enter valid numeric values!");
            };

            std.out("\\nWould you like to try again? (y/n):");
            again = std.input();

            if again == "n" or again == "N" {
                std.out("👋 Thanks for playing! Stay healthy and strong!");
                break;
            };

            self.attempts += 1;
        };
    };
};

# Entry point
with entry {
    walker::weightloss.start();
};
