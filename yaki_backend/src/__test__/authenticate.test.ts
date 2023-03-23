import { authService } from '../features/user/authentication.service';
import { CaptainDtoOut } from '../features/captain/captain.dtoOut';
// import { TeamMateDtoOut } from '../features/teamMate/teamMate.dtoOut';


describe("Service", () => {
  describe("checkPasswords", () => {
    it("should return true if the passwords match", async () => {
      const result = await authService.checkPasswords("password", "password");
      expect(result).toBe(true);
    });

    it("should return false if the passwords do not match", async () => {
      const result = await authService.checkPasswords("password", "notpassword");
      expect(result).toBe(false);
    });
  });
})

  describe("createToken", () => {
    it("should create a valid token for a CaptainDtoOut", async () => {
      const captainDtoOut: CaptainDtoOut = {
        userId: 1, email: "test@test.com",
        captainId: 1,
        lastName: 'lili',
        firstName: 'lala',
        token: undefined
      };
      const result = await authService.createToken(captainDtoOut);
      expect(result.token).toBeDefined();
    });
  })

  //   it("should create a valid token for a TeamMateDtoOut", async () => {
  //     const teamMateDtoOut = { userId: 1, email: "test@test.com" };
  //     const result = await authService.createToken(teamMateDtoOut);
  //     expect(result.token).toBeDefined();
  //   });
  // });

  // describe("verifyToken", () => {
  //   it("should call next if the token is valid", async () => {
  //     const req = { headers: { "x-access-token": "validtoken" }, body: {} };
  //     const res = { status: jest.fn().mockReturnValue({ send: jest.fn() }) };
  //     const next = jest.fn();
  //     jest.spyOn(global.console, "error").mockImplementation(() => {});

  //     const decoded = { user_id: 1 };
  //     jest.spyOn(jwt, "verify").mockReturnValueOnce(decoded);

  //     await authService.verifyToken(req as any, res as any, next);

  //     expect(res.status).not.toHaveBeenCalled();
  //     expect(next).toHaveBeenCalled();
  //   });

  //   it("should return 403 if the token is missing", async () => {
  //     const req = { headers: {}, body: {} };
  //     const res = { status: jest.fn().mockReturnValue({ send: jest.fn() }) };
  //     const next = jest.fn();
  //     jest.spyOn(global.console, "error").mockImplementation(() => {});

  //     await authService.verifyToken(req as any, res as any, next);

  //     expect(res.status).toHaveBeenCalledWith(403);
  //     expect(next).not.toHaveBeenCalled();
  //   });

  //   it("should return 401 if the token is invalid", async () => {
  //     const req = { headers: { "x-access-token": "invalidtoken" }, body: {} };
  //     const res = { status: jest.fn().mockReturnValue({ send: jest.fn() }) };
  //     const next = jest.fn();
  //     jest.spyOn(global.console, "error").mockImplementation(() => {});

  //     jest.spyOn(jwt, "verify").mockImplementationOnce(() => {
  //       throw new Error();
  //     });

  //     await authService.verifyToken(req as any, res as any, next);

  //     expect(res.status).toHaveBeenCalledWith(401);
  //     expect(next).not.toHaveBeenCalled();
  //   });

  ///// un deuxieme exemple

// describe('checkPasswords', () => {
//   it('should return true if the passwords match', async () => {
//     const password = 'password123';
//     const result = await authService.checkPasswords(password, password);
//     expect(result).toBe(true);
//   });

//   it('should return false if the passwords do not match', async () => {
//     const passwordDb = 'password123';
//     const passwordClient = 'password456';
//     const result = await authService.checkPasswords(passwordDb, passwordClient);
//     expect(result).toBe(false);
//   });
// });

// describe('createToken', () => {
//   it('should add a token property to the user object and return it', async () => {
//     const user = { userId: 1, email: 'test@example.com',
//         captainId: 1,
//          lastName: 'dupont',
//          firstName: 'julien',
//         token: undefined
//        }; 
//     const result = await authService.createToken(user);
//     expect(result).toHaveProperty('token');
//     expect(result.token).not.toBeUndefined();
//   });
// });

// describe('verifyToken', () => {
//   const mockRequest = () => {
//     return {
//       headers: {},
//       body: {},
//     };
//   };
//   const mockResponse = () => {
//     const res: any = {};
//     res.status = jest.fn().mockReturnValue(res);
//     res.send = jest.fn().mockReturnValue(res);
//     return res;
//   };
//   const mockNext = jest.fn();

  // it('should return 403 if no token is provided in the headers', async () => {
  //   const req = mockRequest();
  //   const res = mockResponse();
  //   await authService.verifyToken(req, res, mockNext);
  //   expect(res.status).toHaveBeenCalledWith(403);
  //   expect(res.send).toHaveBeenCalledWith('A token is required for authentication');
  // });

  // it('should return 401 if the token is invalid', async () => {
  //   const req = mockRequest();
  //   req.headers['x-access-token'] = 'invalid-token';
  //   const res = mockResponse();
  //   await authService.verifyToken(req, res, mockNext);
  //   expect(res.status).toHaveBeenCalledWith(401);
  //   expect(res.send).toHaveBeenCalledWith('Invalid Token');
  // });

  // it('should set the user property in the request body if the token is valid', async () => {
  //   const user = { userId: 1, email: 'test@example.com' };
  //   const token = jwt.sign(user,


// describe('authService', () => {
//   describe('checkPasswords', () => {
//     it('should return true when the passwords match', async () => {
//       const result = await authService.checkPasswords('password', 'password');
//       expect(result).toBe(true);
//     });

//     it('should return false when the passwords do not match', async () => {
//       const result = await authService.checkPasswords('password', 'not_password');
//       expect(result).toBe(false);
//     });
//   });
// });


// describe('authentificate.service', () => {
//   const user: CaptainDtoOut = {
//     userId: 1, email: 'captain@example.com',
//     captainId: 1,
//     lastName: 'dupont',
//     firstName: 'julien',
//     token: undefined
//   };
//   let token: string | undefined;

//   it('should create a valid token for CaptainDtoOut', async () => {
//     const result = await authService.createToken(user);
//     expect(result.token).toBeDefined();
//     token = result.token;
//   });

//   it('should create a valid token for TeamMateDtoOut', async () => {
//     const user: TeamMateDtoOut = {
//       userId: 2, email: 'teammate@example.com',
//       teamMateId: 1,
//       teamId: 1,
//       lastName: 'lili',
//       firstName: 'lala',
//       token: undefined
//     };
//     const result = await authService.createToken(user);
//     expect(result.token).toBeDefined();
//     token = result.token;
//   });

//   it('should decode a valid token and return user object', async () => {
//     const req: any = { headers: { 'x-access-token': token } };
//     const res: any = {};
//     const next: any = jest.fn();
//     await authService.verifyToken(req, res, next);
//     expect(req.body.user).toBeDefined();
//     expect(req.body.user.user_id).toBe(user.userId);
//     expect(req.body.user.user_email).toBe(user.email);
//   });

//   it('should reject an invalid token', async () => {
//     const req: any = { headers: { 'x-access-token': 'invalidtoken' } };
//     const res: any = { status: jest.fn().mockReturnThis(), send: jest.fn() };
//     const next: any = jest.fn();
//     await authService.verifyToken(req, res, next);
//     expect(res.status).toHaveBeenCalledWith(401);
//     expect(res.send).toHaveBeenCalledWith('Invalid Token');
//   });
// });



// import { authService } from './service';

// describe('authService', () => {
//   const mockCaptain = {
//     userId: 1,
//     email: 'test@test.com',
//     password: 'testpassword',
//   };
//   const mockTeamMate = {
//     userId: 2,
//     email: 'test2@test.com',
//     password: 'testpassword2',
//   };
//   const mockToken = 'mock.token';

//   describe('checkPasswords', () => {
//     it('should return true if passwords match', async () => {
//       const result = await authService.checkPasswords(mockCaptain.password, mockCaptain.password);
//       expect(result).toBe(true);
//     });

//     it('should return false if passwords do not match', async () => {
//       const result = await authService.checkPasswords(mockCaptain.password, 'wrongpassword');
//       expect(result).toBe(false);
//     });
//   });

//   describe('createToken', () => {
//     it('should create a token with the correct user information', async () => {
//       const result = await authService.createToken(mockCaptain);
//       expect(result.token).toBe(mockToken);
//       expect(result.userId).toBe(mockCaptain.userId);
//       expect(result.email).toBe(mockCaptain.email);
//     });
//   });

//   describe('verifyToken', () => {
//     const mockRequest = {
//       headers: {
//         'x-access-token': mockToken,
//         user_id: mockCaptain.userId,
//       },
//       body: {},
//     };
//     const mockResponse = {
//       status: jest.fn().mockReturnThis(),
//       send: jest.fn(),
//     };
//     const mockNext = jest.fn();

//     it('should call next if token is valid and user_id in header matches', async () => {
//       jest.spyOn(jwt, 'verify').mockImplementation(() => ({ user_id: mockCaptain.userId }));

//       await authService.verifyToken(mockRequest as any, mockResponse as any, mockNext);

//       expect(mockRequest.body.user).toEqual({ user_id: mockCaptain.userId });
//       expect(mockNext).toHaveBeenCalled();
//     });

//     it('should return 403 error if token is not provided', async () => {
//       await authService.verifyToken({ headers: {} } as any, mockResponse as any, mockNext);

//       expect(mockResponse.status).toHaveBeenCalledWith(403);
//       expect(mockResponse.send).toHaveBeenCalledWith('A token is required for authentification');
//     });

//     it




