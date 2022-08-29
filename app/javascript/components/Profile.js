import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

import Container from "react-bootstrap/Container";
import Button from "react-bootstrap/Button";
import Card from "react-bootstrap/Card";

const Profile = () => {
  const navigate = useNavigate();
  const [userData, setUserData] = useState({
    username: "",
    role: null,
  });

  useEffect(() => {
    const userInfo = JSON.parse(localStorage.getItem("userInfo"));

    if (userInfo?.username) {
      setUserData({
        username: userInfo.username,
        role: userInfo.role,
      });
    }
  }, [userData.username]);

  const handleLogOut = () => {
    localStorage.removeItem("userInfo");
    navigate("/");
  };

  return (
    <Container className="py-5">
      <Card>
        <Card.Header>Manage your Profile</Card.Header>
        <Card.Body>
          <Card.Title>Role: {userData.role}</Card.Title>
          <Card.Text>
            {userData.role === "seller"
              ? "Manage your products below"
              : "Manage your account below"}
          </Card.Text>
          <Button variant="primary" onClick={handleLogOut}>
            Log out
          </Button>
        </Card.Body>
      </Card>
    </Container>
  );
};
export default Profile;
