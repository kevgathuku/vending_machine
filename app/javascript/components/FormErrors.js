import React from "react";
import isEmpty from "lodash.isempty";
import Alert from "react-bootstrap/Alert";

const FormErrors = ({ formErrors, show, dismiss }) => {
  if (isEmpty(formErrors)) {
    return null;
  }

  if (show) {
    return (
      <div className="pt-3">
        <Alert variant="danger" onClose={dismiss} dismissible>
          <Alert.Heading>
            The following errors prohibited the form from being submitted:
          </Alert.Heading>
          <ul>
            {Object.values(formErrors).map((formError) => (
              <li key={formError}>{formError}</li>
            ))}
          </ul>
        </Alert>
      </div>
    );
  }
};

export default FormErrors;
