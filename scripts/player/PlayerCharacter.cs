using Godot;
using System;

public partial class PlayerCharacter : CharacterBody2D
{
    MovementComponent MoveComponent { get; set; } = null;

    MovementComponent.Direction FaceDirection { get; set; } = MovementComponent.Direction.Down;

    public override void _Ready()
    {
        MoveComponent = GetNode<MovementComponent>("MovementComponent");
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 inputDir = Input.GetVector("Move_Left", "Move_Right", "Move_Up", "Move_Down");

        if (!inputDir.IsZeroApprox())
        {
            FaceDirection = MovementComponent.GetCardinalDirectionFromVector(inputDir);
        }

        Velocity = MoveComponent.CalculateVelocity(Velocity, inputDir, delta);
    }
}
