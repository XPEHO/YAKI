import {authService} from "../features/user/authentication.service";
import {CaptainDtoOut} from "../features/captain/captain.dtoOut";
const jwt = require("jsonwebtoken");
import {Request, Response, NextFunction} from "express";
import bcrypt from "bcrypt";

/* This is a Jest function that clears all mocks after each test to ensure they don't affect other
tests. */
afterEach(() => {
  jest.clearAllMocks(); // Restore all mocks after each test to ensure they don't affect other tests
});

/* Creating a test suite for the authService. */
describe("authService", () => {
  describe("compare password", () => {
    let bcryptCompare: jest.Mock;

    const password = "password123";
    const saltTest = bcrypt.genSaltSync(5);
    const hash = bcrypt.hashSync(password, saltTest);

    beforeEach(async () => {
      bcryptCompare = jest.fn().mockReturnValue(true);
      (bcrypt.compare as jest.Mock) = bcryptCompare;
    });
    it("returns true if the passwords match", async () => {
      const result = await authService.comparePw(password, hash);
      expect(result).toBe(true);
    });
  });

  describe("createToken function", () => {
    const mockCaptain: CaptainDtoOut = new CaptainDtoOut(1, 1, "Doe", "John", "johndoe@example.com");

    /* This is a test that checks if the token is created for the given user and returns the updated
    user object. */
    it("should create a token for the given user and return the updated user object", async () => {
      const mockToken = "mockToken";
      jest.spyOn(jwt, "sign").mockReturnValueOnce(mockToken);
      const result = await authService.createToken(mockCaptain);
      expect(jwt.sign).toHaveBeenCalledWith(
        {
          user_id: mockCaptain.userId,
          user_email: mockCaptain.email,
        },
        `${process.env.TOKEN_SECRET}`,
        {
          expiresIn: "30d",
        }
      );
      expect(result.token).toBe(mockToken);
      expect(result).toEqual(mockCaptain);
    });

    describe("verifyToken function", () => {
      let req: Request;
      let res: Response;
      let next: NextFunction;
      const token = "testToken";
      const decodedToken = {user_id: "12345"};
      beforeEach(() => {
        // Create new mock objects for req, res, and next before each test
        req = {
          headers: {},
          body: {},
        } as Request;
        res = {
          status: jest.fn().mockReturnThis(),
          send: jest.fn(),
        } as unknown as Response;
        next = jest.fn() as unknown as NextFunction;
      });

      /* This is a test that checks if the verifyToken function returns a 403 response when no token is
      provided. */
      it("should return a 403 response when no token is provided", async () => {
        await authService.verifyToken(req, res, next);
        expect(res.status).toHaveBeenCalledWith(403);
        expect(res.send).toHaveBeenCalledWith("A token is required for authentification");
        expect(next).not.toHaveBeenCalled();
      });

      /* This is a test that checks if the verifyToken function returns a 401 response when an invalid
      token is provided. */
      it("should return a 401 response when an invalid token is provided", async () => {
        req.headers["x-access-token"] = "invalid-token";
        await authService.verifyToken(req, res, next);
        expect(res.status).toHaveBeenCalledWith(401);
        expect(res.send).toHaveBeenCalledWith("Invalid Token");
        expect(next).not.toHaveBeenCalled();
      });

      /* This is a test that checks if the verifyToken function successfully verifies a valid token and
      calls the next middleware function. */
      it("should successfully verify a valid token and call the next middleware function", async () => {
        jest.spyOn(jwt, "verify").mockImplementation(() => decodedToken);
        req.headers["x-access-token"] = token;
        req.headers["user_id"] = decodedToken.user_id;
        await authService.verifyToken(req, res, next);
        expect(jwt.verify).toHaveBeenCalledWith(token, process.env.TOKEN_SECRET);
        expect(next).toHaveBeenCalled();
        expect(res.status).not.toHaveBeenCalled();
        expect(res.send).not.toHaveBeenCalled();
      });
    });
  });
});
