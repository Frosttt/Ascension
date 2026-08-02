using Godot;
using System;

public partial class MovementComponent : Node
{
	public enum Direction
	{
		Up,
		Down,
		Left,
		Right
	}

	[Export]
	public float MaxSpeed {get; set; } = 300.0f;

	[Export]
	public float Acceleration { get; set; } = 1200.0f;

	[Export]
	public float Deceleration { get; set; } = 1600.0f;

	public Vector2 CalculateVelocity(Vector2 CurrentVelocity, Vector2 InputDirection, double delta)
	{
		Vector2 targetVel = InputDirection * MaxSpeed;
		float velocityChange = Acceleration;

        if (InputDirection.IsZeroApprox())
        {
			velocityChange = Deceleration;
        }

        return targetVel;
	}

	public static Direction GetCardinalDirectionFromVector(Vector2 Vector)
	{
		if (Mathf.Abs(Vector.X) > Mathf.Abs(Vector.Y))
		{
			return Vector.X >= 0.0f ? Direction.Right : Direction.Left;
		}

		return Vector.Y >= 0.0f ? Direction.Down : Direction.Up;
	}
}
