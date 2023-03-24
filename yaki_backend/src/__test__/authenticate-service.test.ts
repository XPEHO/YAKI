import { authService } from '../features/user/authentication.service';
import { CaptainDtoOut } from '../features/captain/captain.dtoOut';
var jwt = require("jsonwebtoken");
import { Request, Response, NextFunction } from 'express';

<<<<<<< HEAD
/* This is a Jest function that clears all mocks after each test to ensure they don't affect other
tests. */
=======
>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
afterEach(() => {
  jest.clearAllMocks(); // Restore all mocks after each test to ensure they don't affect other tests
});

<<<<<<< HEAD
/* Creating a test suite for the authService. */
=======
>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
describe('authService', () => {
  const passwordDb = 'password123';
  const correctPassword = 'password123';
  const incorrectPassword = 'wrongPassword';
<<<<<<< HEAD
  describe('checkPasswords', () => {
    /* This is a test that checks if the passwords match. */
=======


  describe('checkPasswords', () => {
>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
    it('returns true if the passwords match', async () => {
      const result = await authService.checkPasswords(passwordDb, correctPassword);
      expect(result).toBe(true);
    });

<<<<<<< HEAD
    /* This is a test that checks if the passwords do not match. */
=======
>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
    it('returns false if the passwords do not match', async () => {
      const result = await authService.checkPasswords(passwordDb, incorrectPassword);
      expect(result).toBe(false);
    });
  });

<<<<<<< HEAD
=======

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
  describe('createToken function', () => {
    const mockCaptain: CaptainDtoOut = new CaptainDtoOut(
      1,
      1,
      'Doe',
      'John',
      'johndoe@example.com'
    );

<<<<<<< HEAD
    /* This is a test that checks if the token is created for the given user and returns the updated
    user object. */
    it('should create a token for the given user and return the updated user object', async () => {
      const mockToken = 'mockToken';
      jest.spyOn(jwt, 'sign').mockReturnValueOnce(mockToken);
      const result = await authService.createToken(mockCaptain);
=======
    it('should create a token for the given user and return the updated user object', async () => {
      const mockToken = 'mockToken';
      jest.spyOn(jwt, 'sign').mockReturnValueOnce(mockToken);

      const result = await authService.createToken(mockCaptain);

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
      expect(jwt.sign).toHaveBeenCalledWith(
        {
          user_id: mockCaptain.userId,
          user_email: mockCaptain.email,
        },
<<<<<<< HEAD
        `${process.env.TOKEN_SECRET}`,
=======
        process.env.TOKEN_SECRET,
>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
        {
          expiresIn: '30d',
        }
      );
      expect(result.token).toBe(mockToken);
      expect(result).toEqual(mockCaptain);
    });

    describe('verifyToken function', () => {
      let req: Request;
      let res: Response;
      let next: NextFunction;
      const token = 'testToken';
      const decodedToken = { user_id: '12345' };
<<<<<<< HEAD
=======

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
      beforeEach(() => {
        // Create new mock objects for req, res, and next before each test
        req = {
          headers: {},
          body: {}
        } as Request;
<<<<<<< HEAD
=======

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
        res = {
          status: jest.fn().mockReturnThis(),
          send: jest.fn(),
        } as unknown as Response;
<<<<<<< HEAD
        next = jest.fn() as unknown as NextFunction;
      });

      /* This is a test that checks if the verifyToken function returns a 403 response when no token is
      provided. */
      it('should return a 403 response when no token is provided', async () => {
        await authService.verifyToken(req, res, next);
=======

        next = jest.fn() as unknown as NextFunction;
      });

      it('should return a 403 response when no token is provided', async () => {
        await authService.verifyToken(req, res, next);

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
        expect(res.status).toHaveBeenCalledWith(403);
        expect(res.send).toHaveBeenCalledWith('A token is required for authentification');
        expect(next).not.toHaveBeenCalled();
      });

<<<<<<< HEAD
      /* This is a test that checks if the verifyToken function returns a 401 response when an invalid
      token is provided. */
      it('should return a 401 response when an invalid token is provided', async () => {
        req.headers['x-access-token'] = 'invalid-token';
        await authService.verifyToken(req, res, next);
=======
      it('should return a 401 response when an invalid token is provided', async () => {
        req.headers['x-access-token'] = 'invalid-token';

        await authService.verifyToken(req, res, next);

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
        expect(res.status).toHaveBeenCalledWith(401);
        expect(res.send).toHaveBeenCalledWith('Invalid Token');
        expect(next).not.toHaveBeenCalled();
      });

<<<<<<< HEAD
      /* This is a test that checks if the verifyToken function successfully verifies a valid token and
      calls the next middleware function. */
=======
>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
      it('should successfully verify a valid token and call the next middleware function', async () => {
        jest.spyOn(jwt, 'verify').mockImplementation(() => decodedToken);
        req.headers['x-access-token'] = token;
        req.headers['user_id'] = decodedToken.user_id;
<<<<<<< HEAD
        await authService.verifyToken(req, res, next);
=======

        await authService.verifyToken(req, res, next);

>>>>>>> e84c1fc (test(login_jest): successful unit tests jest of authetificateService)
        expect(req.body.user).toEqual(decodedToken);
        expect(jwt.verify).toHaveBeenCalledWith(token, process.env.TOKEN_SECRET);
        expect(next).toHaveBeenCalled();
        expect(res.status).not.toHaveBeenCalled();
        expect(res.send).not.toHaveBeenCalled();
      });
    });
  });
});

