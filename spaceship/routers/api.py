from fastapi import APIRouter
import numpy as np

router = APIRouter()


@router.get('')
def hello_world() -> dict:
    return {'msg': 'Hello, World!'}

@router.get("/multiply-matrices")
async def multiply_matrices_endpoint():
    matrix_a_np = np.random.rand(10, 10)
    matrix_b_np = np.random.rand(10, 10)

    product_np = np.dot(matrix_a_np, matrix_b_np)
    return {
        "matrix_a": matrix_a_np.tolist(),
        "matrix_b": matrix_b_np.tolist(),
        "product": product_np.tolist(),
    }