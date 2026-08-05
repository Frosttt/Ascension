using Godot;
using System;

public partial class TestLevel : Node2D
{

	[Export] PackedScene PlayerScene { get; set; } = null;

	Node2D PlayerContainer = null;
	Marker2D PlayerSpawn = null;

	public override void _Ready()
	{
		PlayerContainer = GetNode<Node2D>("Players");
		PlayerSpawn = GetNode<Marker2D>("PlayerSpawn");
		SpawnPlayer();
	}

	PlayerCharacter SpawnPlayer()
	{
		PlayerCharacter player = (PlayerCharacter)PlayerScene.Instantiate();

		if (player == null)
			return null;

		PlayerContainer.AddChild(player);
		player.GlobalPosition = PlayerSpawn.GlobalPosition;
		return player;
	}
}
