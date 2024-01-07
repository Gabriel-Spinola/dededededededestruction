using UnityEngine;
using Extensions;
using Unity.VisualScripting;
using UnityEngine.Timeline;

[RequireComponent(typeof(Rigidbody))]
public class Player : MonoBehaviour
{
  [Header("References")]
  [SerializeField] private InputManager _inputs;

  [Header("Movement")]
  [SerializeField] private float _rotationSpeed;
  [SerializeField] private float _moveSpeed;
  [SerializeField] private float _friction;

  private Rigidbody _rigidbody;
  private Vector3 _camRelativeMovement;

  private bool _isWalking = false;

  private void Awake() => _rigidbody = GetComponent<Rigidbody>();

  private void Update() {
    _camRelativeMovement = new Vector3(_inputs.MovementVec.x, 0f, _inputs.MovementVec.y).ConvertToCameraSpace();
    _isWalking = _inputs.MovementVec.x != 0 || _inputs.MovementVec.y != 0;

    HandleBodyRotation();
  }

  private void FixedUpdate()
  {
    if (_isWalking) {
      Walk();
    }
  }

  private void Walk()
  {
    if (_inputs.MovementVec.x != 0) {
      _rigidbody.velocity = new Vector2(_camRelativeMovement.x * _moveSpeed * Time.fixedDeltaTime, _rigidbody.velocity.y);
    }
    else {
      _rigidbody.velocity = new Vector2(Mathf.Lerp(_rigidbody.velocity.x, 0f, _friction * Time.fixedDeltaTime), _rigidbody.velocity.y);
    }
    
    if (_inputs.MovementVec.y != 0) {
      _rigidbody.velocity = new Vector3(_rigidbody.velocity.x, _rigidbody.velocity.y, _camRelativeMovement.z * _moveSpeed * Time.fixedDeltaTime);
    }
    else {
      _rigidbody.velocity = new Vector3(_rigidbody.velocity.x, _rigidbody.velocity.y, Mathf.Lerp(_rigidbody.velocity.z, 0f, _friction * Time.fixedDeltaTime));
    }
  }

  private void HandleBodyRotation()
  {
    Quaternion currentRotation = transform.rotation;

    if (_isWalking) {
      var targetRotation = Quaternion.LookRotation(_camRelativeMovement);

      transform.rotation = Quaternion.Slerp(currentRotation, targetRotation, _rotationSpeed * Time.deltaTime);
    }
  }
}
