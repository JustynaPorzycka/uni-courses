import argparse
from scipy.optimize import newton

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('equation', type=str, help='Newton method')
    parser.add_argument('-sp', type = float, default = 0.0, help = 'start point')
    parser.add_argument('-i', type = int, default = 100, help = 'max iteration value')
    parser.add_argument('-t', type = float, default = 1.48e-8, help = 'tolerance')

    args = parser.parse_args()

    equation = ''.join(filter(lambda c: 
                        str.isdigit(c) or 
                        c in 'x.+-*', 
                        args.equation))
    
    py_equation = lambda x: eval(equation)

    result = newton(py_equation, args.sp, tol = args.t, maxiter = args.i)

    print(result)