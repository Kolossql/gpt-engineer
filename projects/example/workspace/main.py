from model import SnakeGame
from view import SnakeView
from controller import SnakeController

def main():
    # Create instances of the game model, view, and controller
    game = SnakeGame()
    view = SnakeView()
    controller = SnakeController()

    # Game loop
    while True:
        # Get user input
        key = controller.get_user_input()

        # Handle user input
        controller.handle_input(key)

        # Move the snake
        game.move_snake()

        # Check for collisions
        game.check_collision()

        # Generate food
        game.generate_food()

        # Render the game state
        view.render_board()
        view.render_snake()
        view.render_food()
        view.update_display()

if __name__ == "__main__":
    main()
