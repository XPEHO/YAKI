const request = require('supertest');
const app = 'http://localhost:3000';

describe('post /login', () => {
  test('Should login user', async () => {
    await request(app)
      .post('/login')
      .send({
        login: 'dugrand',
        password: 'dugrand',
      })
      .expect(200);
  });

  test('Should fail login user', async () => {
    await request(app)
      .post('/login')
      .send({
        login: 'dugrand',
        password: 'duGrand',
      })
      .expect(204);
  });

  // describe('get /captains', () => {
  //   test('Should get captains', async () => {
  //     await request(app)
  //       .get('/captains')
  //       .send({
  //         login: 'lavigne',
  //         password: 'lavigne',
  //       })
  //       .expect(200);
  //   });
  //   test('Should not get captains', async () => {
  //     await request(app)
  //       .get('/captains')
  //       .send({
  //         login: 'lavigne',
  //         password: 'wrongPassword',
  //       })
  //       .expect(204);
  //   });
  // });

  // describe('get /teamMates', () => {
  //   test('Should get teammates', async () => {
  //     await request(app).get('/teamMates').expect(200);
  //   });
  //   test('Should not get teammates', () => {
  //     request(app).get('/teamMate').expect(204);
  //   });
  // });
});
