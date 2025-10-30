"""A weightloss tracking game"""

use byllm;

@agent(model_name="gemini-2.5-flash", verbose=False);

def give_proper_weight(weight: float, height: float, proper_weight: float) -> str by llm();

# Each turn architype(node) holds the proper_weight to be displayed after weight and height input.
architype turn:
    has proper_weight: str; 

    def on_spawn(weight: float, height: float):
        self.proper_weight = give_proper_weight(weight, height)
        std.log("📤Your Proper weight: ")
        std.log(self.proper_weight)

walker Weightloss:
    # walker attributes
    has attempts: int = 1;
    has input_weight: float = 0.0;
    has input_height: float = 0.0;

    # walker abilities.
    can start;
    can process_weight_and_height;

    # define start function
    def start():
        std.log("🏁 Welcome to the Weightloss Game!")
        std.log("Let's begin tracking your healthy weight journey.😎")

    # Interactive inputs 
        self.input_weight = float(input("Enter your current weight (kg): "))
        self.input_height = float(input("Enter your height (cm): "))

        self.process_weight_and_height()

    # define process_weight_and_height function.
    def process_weight_and_height():
        std.log("📥Processing your data...")
        spawn here ++ turn(weight=self.input_weight, height=self.input_height)
    
with entry:
    walker = weightloss()
    walker.start()
