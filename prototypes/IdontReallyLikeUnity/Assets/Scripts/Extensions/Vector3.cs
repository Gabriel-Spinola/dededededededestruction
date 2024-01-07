using UnityEngine;

namespace Extensions
{
  public static class Vector3Extension
  {
    public static Vector3 ConvertToCameraSpace(this Vector3 target)
    {
      var cameraForward = Camera.main.transform.forward;
      var cameraRight = Camera.main.transform.right;

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
}