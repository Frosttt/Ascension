using Godot;
using System;

public partial class PlayerCharacter : CharacterBody2D
{
	public MovementComponent MoveComponent { get; set; } = null;
	MovementComponent.Direction FaceDirection { get; set; } = MovementComponent.Direction.Down;

	public Sprite2D Sprite { get; set; } = null;


	public override void _Ready()
	{
		MoveComponent = GetNode<MovementComponent>("MovementComponent");
		Sprite = GetNode<Sprite2D>("Sprite");
	}

	public override void _PhysicsProcess(double delta)
	{
		Vector2 inputDir = Input.GetVector("Move_Left", "Move_Right", "Move_Up", "Move_Down");

		if (!inputDir.IsZeroApprox())
		{
			FaceDirection = MovementComponent.GetCardinalDirectionFromVector(inputDir);
		}

		switch (FaceDirection)
		{
			case MovementComponent.Direction.Left:
				Sprite.Scale = new Vector2(-Mathf.Abs(Sprite.Scale.X), Sprite.Scale.Y);
				break;
			case MovementComponent.Direction.Right:
				Sprite.Scale = new Vector2(Mathf.Abs(Sprite.Scale.X), Sprite.Scale.Y);
				break;
			default:
			break;
		}

		Velocity = MoveComponent.CalculateVelocity(Velocity, inputDir, delta);
		GD.Print(Velocity);
	}
}
