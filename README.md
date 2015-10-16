# FLDFaceDetectionMATLAB
Implementation of the Fisher Linear Discriminant (FLD) based algorithm for Face Recognition

Our approach to face recognition exploits two observations:
> 1. All of the images of a Lambertian surface, taken from a fixed viewpoint lie in a 3D linear subspace of the high-dimensional image space. 
> 2. Because of different facial expressions the above observation does not exactly hold. In practice, certain regions of the face may have variability from image to image that often deviates significantly from the liner subspace and are less
reliable for recognition.

We make use of these observations by finding a linear projection of the faces from the
high-dimensional image space to a significantly lower dimensional feature space which is
insensitive to variation in facial expression. We choose projection directions that are
nearly orthogonal to the within-class scatter, projecting away variations in facial
expressions while maintaining discriminability. Our method Fisherfaces, a derivative of
Fisher’s Linear Discriminant (FLD) maximizes the ratio of between-class scatter to that
of within-class scatter.
