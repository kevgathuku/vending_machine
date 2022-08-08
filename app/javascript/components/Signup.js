import React, { useState } from "react";
import { css } from "@emotion/react";
import isEmpty from "lodash.isempty";
import { useNavigate } from "react-router-dom";

import Button from "react-bootstrap/Button";
import Container from "react-bootstrap/Container";
import Form from "react-bootstrap/Form";

import FormErrors from "./FormErrors";

const formContainer = css`
  max-width: 330px;
`;

const validateForm = (userData) => {
  const errors = {};

  if (userData.username === "") {
    errors.username = "Please enter a username";
  }

  if (userData.password === "") {
    errors.password = "Please enter a password";
  }

  if (userData.passwordConfirmation === "") {
    errors.passwordConfirmation = "Please confirm your password";
  }

  if (userData.password !== userData.passwordConfirmation) {
    errors.event_date = "Please enter matching passwords";
  }

  if (![0, 1].includes(userData.role)) {
    errors.role = "Please select a role";
  }

  return errors;
};

const SignUp = () => {
  const [userData, setUserData] = useState({
    username: "",
    role: undefined,
    password: "",
    passwordConfirmation: "",
  });
  const [formErrors, setFormErrors] = useState({});
  const [showFormErrors, setShowFormErrors] = useState(true);
  const navigate = useNavigate();

  const handleInputChange = (e) => {
    const { target } = e;
    const { name, value } = target;

    setUserData((prevState) => {
      return {
        ...prevState,
        [name]: name === "role" ? parseInt(value) : value,
      };
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const errors = validateForm(userData);

    if (!isEmpty(errors)) {
      setFormErrors(errors);
      setShowFormErrors(true);
    } else {
      setShowFormErrors(false);
      console.log("Valid user data", userData);
      addUser(userData);
    }
  };
  
  const addUser = async (newUser) => {
    const { passwordConfirmation, ...userFormData } = newUser;
    try {
      const response = await window.fetch("/api/users", {
        method: "POST",
        body: JSON.stringify({
          user: userFormData,
        }),
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      });
      if (!response.ok) throw Error(response.statusText);

      const savedUser = await response.json();
      console.log("savedUser", savedUser);
      window.alert("User Created!");
      navigate(`/`);
      // TODO: Fetch the user token and save it here
    } catch (error) {
      // TODO: Show the error to the user
      console.error(error);
    }
  };

  return (
    <section>
      {showFormErrors && (
        <FormErrors
          formErrors={formErrors}
          show={!isEmpty(formErrors)}
          dismiss={() => setShowFormErrors(false)}
        />
      )}
      <Container>
        <Form
          className="w-100 mx-auto py-5"
          css={formContainer}
          onSubmit={handleSubmit}
        >
          <Form.Group className="mb-3" controlId="username">
            <Form.Label>Username</Form.Label>
            <Form.Control
              type="text"
              placeholder="Enter username"
              onChange={handleInputChange}
              name="username"
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="password">
            <Form.Label>Password</Form.Label>
            <Form.Control
              type="password"
              placeholder="Password"
              onChange={handleInputChange}
              name="password"
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="passwordConfirm">
            <Form.Label>Password Confirmation</Form.Label>
            <Form.Control
              type="password"
              placeholder="Password"
              onChange={handleInputChange}
              name="passwordConfirmation"
            />
          </Form.Group>

          <Form.Group className="mb-3" controlId="role">
            <Form.Select
              aria-label="Select Role"
              onChange={handleInputChange}
              name="role"
            >
              <option>Select a role</option>
              <option value="0">Buyer</option>
              <option value="1">Seller</option>
            </Form.Select>
          </Form.Group>

          <Button variant="primary" type="submit">
            Submit
          </Button>
        </Form>
      </Container>
    </section>
  );
};
export default SignUp;
