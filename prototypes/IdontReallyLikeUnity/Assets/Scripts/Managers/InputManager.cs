using UnityEngine;
using UnityEngine.SceneManagement;

public class InputManager : MonoBehaviour
{
    public MainInputs InputActions { get; private set; }

    [SerializeField] private Vector2 _movementVec;

    [SerializeField] private bool _keyJump;
    [SerializeField] private bool _keyJumpHold;
    [SerializeField] private bool _keyShoot;

    public Vector2 MovementVec => _movementVec;

    public bool KeyJump => _keyJump;
    public bool KeyJumpHold => _keyJumpHold;
    public bool KeyShoot => _keyShoot;

    private void Awake()
    {
        InputActions = new MainInputs();

        InputActions.Player.Enable();
    }

    private void Update()
    {
#if UNITY_EDITOR
        if (Input.GetKeyDown(KeyCode.RightAlt)) {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
#endif

        _movementVec = InputActions.Player.Movement.ReadValue<Vector2>();
        _keyJumpHold = InputActions.Player.JumpHold.ReadValue<float>() > 0f;

        _keyJump = InputActions.Player.Jump.triggered;
    }
}
