using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class Player : MonoBehaviour
{
  [Header("References")]
  [SerializeField] private InputManager _inputs;

  [Header("Stats")]
  [SerializeField] private float _moveSpeed;
  [SerializeField] private float _friction;

  private Rigidbody _rigidbody;

  private void Awake()
  {
    _rigidbody = GetComponent<Rigidbody>();
  }

  private void FixedUpdate()
  {
    Movement();
  }

  private void Movement()
  {
    Vector3 camRelativeMovement = ConvertToCameraSpace(new Vector3(_inputs.MovementVec.x, 0f, _inputs.MovementVec.y));

    if (_inputs.MovementVec.x != 0) {
      _rigidbody.velocity = new Vector2(camRelativeMovement.x * _moveSpeed * Time.fixedDeltaTime, _rigidbody.velocity.y);
    }
    else {
      _rigidbody.velocity = new Vector2(Mathf.Lerp(_rigidbody.velocity.x, 0f, _friction * Time.fixedDeltaTime), _rigidbody.velocity.y);
    }
    
    if (_inputs.MovementVec.y != 0) {
      _rigidbody.velocity = new Vector3(_rigidbody.velocity.x, _rigidbody.velocity.y, camRelativeMovement.z * _moveSpeed * Time.fixedDeltaTime);
    }
    else {
      _rigidbody.velocity = new Vector3(_rigidbody.velocity.x, _rigidbody.velocity.y, Mathf.Lerp(_rigidbody.velocity.z, 0f, _friction * Time.fixedDeltaTime));
    }
  }

  private Vector3 ConvertToCameraSpace(Vector3 target) {
    Vector3 cameraForward = Camera.main.transform.forward;
    Vector3 cameraRight = Camera.main.transform.right;

    // Ignore upward/downward camera angles
    // And Normalize vectors so we can have its coordinate space
    cameraForward = new Vector3(cameraForward.x, 0f, cameraForward.z).normalized;
    cameraRight = new Vector3(cameraRight.x, 0f, cameraRight.z).normalized;

    // Rotate to camera space
    Vector3 cameraForwardZProduct = target.z * cameraForward;
    Vector3 cameraRightXProduct = target.x * cameraRight;

    return cameraForwardZProduct + cameraRightXProduct;
  }
}
