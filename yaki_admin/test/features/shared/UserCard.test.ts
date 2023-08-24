import { describe,it,expect } from 'vitest';
import UserComponent from '../../../src/features/shared/components/UserCard.vue'; // Update the path to match your component's location
import { mount } from '@vue/test-utils';

describe('UserComponent', () => {
  it('displays user information correctly', async () => {
    const user = {
      id: 1,
      firstname: 'John',
      lastname: 'Doe',
      email: 'john@example.com',
    };

    const wrapper = mount(UserComponent, {
      props: {
        user,
      },
    });

    // Assert user's name is displayed correctly
    expect(wrapper.text()).toContain('John Doe');
    
    // Assert user's email is displayed correctly
    expect(wrapper.text()).toContain('john@example.com');

    // You can also check if the avatar, edit icon, and delete icon are displayed correctly.
    // You might need to use the "find" or "findAll" methods from the wrapper to target specific elements.
  });

  // it('emits "removeUser" event when delete button is clicked', async () => {
  //   const user = {
  //     id: 1,
  //     firstname: 'John',
  //     lastname: 'Doe',
  //     email: 'john@example.com',
  //   };

  //   const wrapper = mount(UserComponent, {
  //     props: {
  //       user,
  //     },
  //   });


  //   // Click the delete button
  //   await wrapper.find('button').trigger('click');

  //   // Check if the "removeUser" event was emitted with the correct arguments
  //   expect(wrapper.vm.$emit).toHaveBeenCalledWith('removeUser', user.id, 'John Doe');
  // });
});