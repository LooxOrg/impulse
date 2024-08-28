namespace impulse
{
  class Vector2
  {
  public:
    float x, y;

    Vector2() : x(0), y(0) {}
    Vector2(float x, float y) : x(x), y(y) {}

    Vector2 add(const Vector2 &other) const
    {
      return Vector2(
          x + other.x,
          y + other.y);
    }

    Vector2 subtract(const Vector2 &other) const
    {
      return Vector2(
          x - other.x,
          y - other.y);
    }

    Vector2 multiply(const Vector2 &other) const
    {
      return Vector2(
          x * other.x,
          y * other.y);
    }

    Vector2 divide(const Vector2 &other) const
    {
      return Vector2(
          x / other.x,
          y / other.y);
    }
  };

  class Vector3
  {
  public:
    float x, y, z;

    Vector3() : x(0), y(0), z(0) {}
    Vector3(float x, float y, float z) : x(x), y(y), z(z) {}

    Vector3 add(const Vector3 &other) const 
    {
      return Vector3(
          x + other.x,
          y + other.y,
          z + other.z);
    }

    Vector3 subtract(const Vector3 &other) const
    {
      return Vector3(
          x - other.x,
          y - other.y,
          z - other.z);
    }

    Vector3 multiply(const Vector3 &other) const
    {
      return Vector3(
          x * other.x,
          y * other.y,
          z * other.z);
    }

    Vector3 divide(const Vector3 &other) const
    {
      return Vector3(
          x / other.x,
          y / other.y,
          z / other.z);
    }
  };

  class Vector4
    {
    public:
      float x, y, z, w;

      Vector4() : x(0), y(0), z(0), w(0) {}
      Vector4(float x, float y, float z, float w) : x(x), y(y), z(z), w(w) {}

      Vector4 add(const Vector4 &other) const
      {
        return Vector4(
            x + other.x,
            y + other.y,
            z + other.z,
            w + other.w);
      }

      Vector4 subtract(const Vector4 &other) const
      {
        return Vector4(
            x - other.x,
            y - other.y,
            z - other.z,
            w - other.w);
      }

      Vector4 multiply(const Vector4 &other) const
      {
        return Vector4(
            x * other.x,
            y * other.y,
            z * other.z,
            w * other.w);
      }

      Vector4 divide(const Vector4 &other) const
      {
        return Vector4(
            x / other.x,
            y / other.y,
            z / other.z,
            w / other.w);
      }
    };
}
