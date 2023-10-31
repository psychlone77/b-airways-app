import { Link } from 'react-router-dom';

export default function Error() {
    const searchParams = new URLSearchParams(window.location.search);
    const error = searchParams.get('error');

    return (
        <div>
            <h1>Login Error</h1>
            <p>{error}</p>
            <Link to="/login">Go back to login page</Link>
        </div>
    );
}
